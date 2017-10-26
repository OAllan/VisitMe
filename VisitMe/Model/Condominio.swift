//
//  Condominio.swift
//  VisitMe
//
//  Created by Aldo on 10/26/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class Condominio{
    var id: String?
    var adminEncargado: Admin?
    var direccion: String?
    var longitud: Double?
    var latitud: Double?
    
    init(id: String, adminEncargado: Admin, direccion:String, latitud:Double, longitud:Double){
        self.id = id
        self.adminEncargado = adminEncargado
        self.direccion = direccion
        self.latitud = latitud
        self.longitud = longitud
        
        func getId() -> String{
            return self.id!
        }
        
        func getDireccion() -> String{
            return self.direccion!
        }
        
        func getLatitud() -> Double{
            return self.latitud!
        }
        
        func getLongitud() -> Double{
            return self.longitud!
            
        }
        
        func getAdmin() -> Admin{
            return self.adminEncargado!
        }
        
        func setId(id: String){
            self.id = id
        }
        
        func setDireccion(direccion: String){
            self.direccion = direccion
        }
        
        func setLatitud(latitud: Double){
            self.latitud = latitud
        }
        
        func setLongitud(longitud: Double){
            self.longitud = longitud
        }
        
        func setAdmin(adminEncargado: Admin){
            self.adminEncargado = adminEncargado
        }
        
    }
}
