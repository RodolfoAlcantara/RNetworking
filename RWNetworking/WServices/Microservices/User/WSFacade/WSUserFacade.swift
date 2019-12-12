//
//  WSUserFacade.swift
//  RWNetworking
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 04/12/19.
//  Copyright © 2019 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

import Foundation

public class WSUserFacade: NSObject {
    public var serviceProtocolDelegate: ServicesProtocol?
    
    public func getUserInfo(code: String, token: String) {
        let wes = URLUSER()
        let connection = WSConnectionManager()
        let url = connection.getURLCustom(urlRequest: wes.WSUSERGETDATA, urlMethod: .get, headers: ["Content-Type": "application/json"])
        connection.delegate = self
        connection.startConnectionWithCustomRequest(urlRequest: url, serviceName: .Servicio1)
    }
}

extension WSUserFacade: WSDelegate {
    func didReceiveData(data: Data, serviceName: WSNAME) {
        switch serviceName {
        case .Servicio1:
            do {
                let retrievedEntity = try JSONDecoder().decode(RWNetworkingEntity.self, from: data)
                self.serviceProtocolDelegate?.didReceiveEntity(serviceName: serviceName, entity: retrievedEntity)
            } catch {
                print("parse error")
            }
        case .Servicio2:
            print("Servicio2")
            /*
            let retrievedEntity = try JSONDecoder().decode(RWNetworkingEntity2.self, from: data)
                           self.serviceProtocolDelegate?.didReceiveEntity(serviceName: serviceName2, entity: retrievedEntity)
            */
        }
    }
    
    func didReceiveError(error: Error, serviceName: WSNAME) {
        switch serviceName {
        case .Servicio1:
            let errorMessage = RWBaseEntity(code: 1, message: error.localizedDescription)
            serviceProtocolDelegate?.didReceiveEntity(serviceName: serviceName, entity: errorMessage)
        default:
            let errorMessage = RWBaseEntity(code: -1, message: "fatal error")
            serviceProtocolDelegate?.didReceiveEntity(serviceName: serviceName, entity: errorMessage)
        }
    }
}

