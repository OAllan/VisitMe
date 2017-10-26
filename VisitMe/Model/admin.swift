//
//  admin.swift
//  VisitMe
//
//  Created by Manuel Castilla on 25/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class Admin{
    
    var idAdmin: Int?
    
    var nombreAdmin: String?
    
    var apellidoAdmin: String?
    
    
    
    init(idAdmin: Int, nombreAdmin: String, apellidoAdmin: String){
        
        self.idAdmin = idAdmin
        
        self .nombreAdmin = nombreAdmin
        
        self.apellidoAdmin = apellidoAdmin
        
        
        
        func getId() -> Int?{
            
            return self.idAdmin
            
        }
        
        
        
        func getNombreAdmin() -> String?{
            
            return self.nombreAdmin
            
        }
        
        func getApellidoAdmin() -> String?{
            
            return self.apellidoAdmin
            
        }
        
        func setId(idAdmin: Int) {
            
            self.idAdmin = idAdmin
            
        }
        
        
        
        func setNombreAdmin(nombreAdmin: String){
            
            self.nombreAdmin = nombreAdmin
            
        }
        
        
        
        func setApellidoAdmin(apellidoAdmin: String){
            
            self.apellidoAdmin = apellidoAdmin
            
        }
        
}

}
