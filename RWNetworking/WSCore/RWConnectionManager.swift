//
//  RWConnectionManager.swift
//  RWNetworking
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 25/11/19.
//  Copyright © 2019 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

import Alamofire

protocol WSDelegate {
    func didReceiveData(data: Data, serviceName: WSNAME)
    func didReceiveError(error: Error, serviceName: WSNAME)
}

class WSConnectionManager: NSObject {
    public var delegate: WSDelegate?
    private var manager: SessionManager = SessionManager.default
    
    override init() {
        super.init()
        
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "apple.com": .pinCertificates(certificates: getCertificates(typeCertificate: "cer"), validateCertificateChain: true, validateHost: true),
            "google.com": .disableEvaluation
        ]
        
        self.manager = Alamofire.SessionManager(configuration: loadConfiguration(), delegate: SessionDelegate(), serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
    }
    
    private func loadConfiguration() -> URLSessionConfiguration {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 10.0
        sessionConfiguration.timeoutIntervalForRequest = 10.0
        return sessionConfiguration
    }
    
    private func getCertificates(typeCertificate: String) -> [SecCertificate] {
        let certificatesName = getCertificatesName()
        var localCertificates = [SecCertificate]()
        guard let bundleReturned = Bundle.init(identifier: "com.rodolfo.RWNetworking") else { return [SecCertificate]() }
        for cert in certificatesName {
            guard let pathToCert = bundleReturned.path(forResource: cert, ofType: typeCertificate) else { return [SecCertificate]() }
            if let localCertificate: NSData = NSData(contentsOfFile: pathToCert) {
                if let serLocalCertificate = SecCertificateCreateWithData(nil, localCertificate) {
                    localCertificates.append(serLocalCertificate)
                }
            }
        }
        return localCertificates
    }
    
    private func getCertificatesName() -> [String] {
        return ["www_google_com", "www_apple_com"]
    }
    
    internal func getURLCustom<T: Encodable>(object: T, urlRequest: String, urlMethod: HTTPMethod, headers: [String: String]) -> URLRequest {
        let encoder = JSONEncoder()
        let url = URL(string: urlRequest)
        var request = URLRequest(url: url!)
        request.httpMethod = urlMethod.rawValue
        for header in headers { request.setValue(header.value, forHTTPHeaderField: header.key) }
        do {
            let encodedData = try encoder.encode(object)
            #if DEBUG
            let jsonString = String(data: encodedData, encoding: .utf8)
            print(jsonString ?? "Parse error")
            #endif
            request.httpBody = encodedData
        } catch {
            print("Error")
        }
        return request
    }
    
    internal func getURLCustom(urlRequest: String, urlMethod: HTTPMethod, headers: [String: String]) -> URLRequest {
        let url = URL(string: urlRequest)
        var request = URLRequest(url: url!)
        request.httpMethod = urlMethod.rawValue
        for header in headers { request.setValue(header.value, forHTTPHeaderField: header.key) }
        return request
    }
    
    internal func startConnectionWithCustomRequest(urlRequest: URLRequest, serviceName: WSNAME) {
        self.manager.request(urlRequest).responseData { (response) -> Void in
            #if DEBUG
            print("Resquest: \(String(describing: response.request))")
            let responseS = String(data: response.data!, encoding: .utf8)
            print("Response \(String(describing: responseS))")
            print("Response Time \(response.timeline)")
            #endif
            switch response.result {
                case .success:
                    self.delegate?.didReceiveData(data: response.data!, serviceName: serviceName)
                    return
                case .failure(let error):
                    print("Error \(error.localizedDescription)")
                    self.delegate?.didReceiveError(error: NSError(), serviceName: serviceName)
                    return
            }
        }
    }
    
}
