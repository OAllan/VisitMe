//
//  Usuario.swift
//  VisitMe
//
//  Created by Aldo Alberto Aguilar Bermúdez on 23/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class Usuario {
    
    var idUsuario: String?
    var nombres: String?
    var apellidoPaterno: String?
    var apellidoMaterno: String?
    
    init(idUsuario: String, nombres: String, apellidoPaterno: String, apellidoMaterno: String) {
        self.idUsuario = idUsuario
        self.nombres = nombres
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        
        func getIdUsuario() ->{
            return self.idUsuario!
        }
        
        func getNombres() -> String{
            return self.nombres!
        }
        
        func getApellidoPaterno() -> String {
            return self.apellidoPaterno!
        }
        
        func getApellidoMaterno() -> String {
            return self.apellidoMaterno!
        }
        
        func setIdUsuario(idUsuario: String){
            self.idUsuario = idUsuario
        }
        
        func setNombres(nombres: String){
            self.nombres = nombres
        }
        
        func setApellidoPaterno(apellidoPaterno: String){
            self.apellidoPaterno = apellidoPaterno
        }
        
        func setApellidoMaterno(apellidoMaterno: String){
            self.apellidoMaterno = apellidoMaterno
        }
        
        
    }
    
}
