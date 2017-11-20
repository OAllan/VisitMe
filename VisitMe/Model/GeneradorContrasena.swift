//
//  GeneradorContrasena.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 19/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class GeneradorContrasena {
    
    func generarContrasena() ->String{
        let caracteres = Array("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890".characters)
        var contrasena = ""
        let len = 12
        for _ in 0..<len {
            let rand = arc4random_uniform(UInt32(caracteres.count))
            contrasena.append(caracteres[Int(rand)])
        }
        
        return contrasena
    }
}
