//
//  Condominio.swift
//  VisitMe
//
//  Created by Aldo on 10/26/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class Condominio {
    var id: String?
    var adminEncargado: Admin?
    var calle: String?
    var numero: String?
    var colonia: String?
    var cp: String?
    var ciudad: String?
    var estado: String?
    
    init(id: String, adminEncargado: Admin, calle: String, numero: String, colonia: String, cp: String, ciudad: String, estado: String){
        self.id = id
        self.adminEncargado = adminEncargado
        self.calle = calle
        self.numero = numero
        self.colonia = colonia
        self.cp = cp
        self.ciudad = ciudad
        self.estado = estado
    }
        
    func getId() -> String{
        return self.id!
    }
    
        
        
    func getAdmin() -> Admin{
        return self.adminEncargado!
    }
        
    func setId(id: String){
        self.id = id
    }
        
        
        
    func setAdmin(adminEncargado: Admin){
        self.adminEncargado = adminEncargado
    }
    
    func getDireccionCompleta() -> String{
        return "\(calle!) \(numero!), \(colonia!).\n\(ciudad!), \(estado!). CP: \(cp!)"
    }
        
    
}
