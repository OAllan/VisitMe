//
//  ResidenteController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class ResidenteController: UIViewController{
    
    var residente: Usuario? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func buscarInvitacion(){
        
    }
    
    func cargarInformacion(email: String){
        /*nombreLabel.text = residente?.nombre
        apellidoTf.text = "\(String(describing: residente?.apellidoPaterno)) \(String(describing: residente?.apellidoMaterno))"
        self.email.text = email*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
