//
//  VigilanteController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit
import BarcodeScanner

class VigilanteController: UIViewController {
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var apellidoTf: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var vigilante: Vigilante? = nil
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    
    func cargarInformacion(email: String){
        nombreLabel.text = vigilante?.nombre
        apellidoTf.text = "\(vigilante!.apellidoPaterno!) \(vigilante!.apellidoMaterno!)"
        self.email.text = email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
