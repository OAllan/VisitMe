//
//  Admin.swift
//  VisitMe
//
//  Created by Aldo on 10/26/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class Admin: UsuarioVisitMe {
    
    
    init(id: String, nombre:String, apellidoPaterno:String, apellidoMaterno:String, email: String){
        super.init()
        self.id = id
        self.nombre = nombre
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.email = email
    }
        
    func getId() -> String{
        return self.id!
    }
    
    func getNombre() -> String{
        return self.nombre!
    }
        
    func getApellidoPaterno() -> String{
        return self.apellidoPaterno!
    }
        
    func getApellidoMaterno() -> String{
        return self.apellidoPaterno!
        
    }
        
    func getEmail() -> String{
        return self.email!
    }
        
    func setId(id: String){
        self.id = id
    }
        
    func setNombre(nombre: String){
        self.nombre = nombre
    }
        
    func setApellidoPaterno(apellidoPaterno: String){
        self.apellidoPaterno = apellidoPaterno
    }
        
    func setApellidoMaterno(apellidoMaterno: String){
        self.apellidoMaterno = apellidoMaterno
    }
        
    func setEmail(email: String){
        self.email = email
    }
}
