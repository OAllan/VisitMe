//
//  InvitadoController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 14/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class InvitadoController: UIViewController{
    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var apellidoPaterno: UITextField!
    
    @IBOutlet weak var apellidoMaterno: UITextField!
    
    
    @IBOutlet weak var placas: UITextField!
    
    
    @IBOutlet weak var fecha: UIDatePicker!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var carroSwitch: UISwitch!
    
    var usuario: Usuario?
    
    
    
    
   
    
    
    
    @IBAction func carroBool(_ sender: UISwitch) {
       
        if carroSwitch.isOn{
            placas.isEnabled = true
        }else{
            placas.isEnabled = false
        }
    
    }
    
    
    @IBAction func placasTexto(_ sender: UITextField) {
        if placas.isEnabled == true && placas.text?.contains("Placas") == true{
            placas.text = ""
            placas.textColor = UIColor.black
        }
    }
    
    
    
    
    
}
