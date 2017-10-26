//
//  ResidenteController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class ResidenteController: UIViewController{
    
    @IBOutlet weak var nombreLabel: UILabel!
    var residente: Usuario? = nil
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var apellidoTf: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func cargarInformacion(email: String){
        nombreLabel.text = residente?.nombre
        apellidoTf.text = "\(residente!.apellidoPaterno!) \(residente!.apellidoMaterno!)"
        self.email.text = email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
