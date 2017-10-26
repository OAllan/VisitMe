//
//  CondoVigilante.swift
//  VisitMe
//
//  Created by Aldo on 10/26/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class CondoVigilante{
    
    //Var instancia
    
    var idVigilante: String?
    var idCondominio: String?
    
    //Constructor
    
    init(idVigilante: String, idCondominio: String){
        self.idVigilante = idVigilante
        self.idCondominio = idCondominio
    }
    
    //Getters
    
    func getIdVigilante() -> String{
        return self.idVigilante!
    }
    
    func getIdCondominio() -> String{
        return self.idCondominio!
    }
    
    //Setters
    
    func setIdVigilante(idVigilante: String){
        self.idVigilante = idVigilante
    }
    
    func setIdCondominio(idCondominio: String){
        self.idCondominio = idCondominio
    }
}
