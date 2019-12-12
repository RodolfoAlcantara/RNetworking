//
//  ServicesProtocol.swift
//  RWNetworking
//
//  Created by Rodolfo Benjamin Alcantara Solorio on 09/12/19.
//  Copyright © 2019 Rodolfo Benjamin Alcantara Solorio. All rights reserved.
//

/**
 Protocolo que envía las entidades necesarias para que las muestre en la aplicación.
 */
public protocol ServicesProtocol {
    /**
     Parametro para el envío de información
     - parameters:
        - serviceName: Es el nombre identificador del servicio.
        - entity: Es la entidad que regresa la información.
     */
    func didReceiveEntity<T>(serviceName: WSNAME, entity: T)
}

