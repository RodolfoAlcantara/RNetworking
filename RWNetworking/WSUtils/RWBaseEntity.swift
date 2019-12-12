//
//  RWBaseEntity.swift
//  RWNetworking
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 09/12/19.
//  Copyright © 2019 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

public class RWBaseEntity: Codable {
    public var code = -1
    public var message = "Error"
    public init(code: Int, message: String) {
        self.code = code
        self.message =  message
    }
}
