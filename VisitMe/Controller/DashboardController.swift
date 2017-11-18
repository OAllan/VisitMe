//
//  ResidenteController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class DashboardController: UIViewController{
    
    @IBOutlet weak var nombreLabel: UILabel!
    var residente: Usuario? = nil
    var type: String?
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var apellidoTf: UILabel!
    
    var usuario: Usuario?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pantallaInicial = storyBoard.instantiateViewController(withIdentifier: "pantallaInicial") as! ViewController
        present(pantallaInicial, animated: true, completion: nil)
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
