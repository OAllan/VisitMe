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
    var usuario: UsuarioVisitMe? = nil
    var type: String?
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var apellidoTf: UILabel!
    var condominio: Condominio?
    
    @IBOutlet weak var condominioText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pantallaInicial = storyBoard.instantiateViewController(withIdentifier: "pantallaInicial") as! ViewController
        present(pantallaInicial, animated: true, completion: nil)
    }
    
    
    func cargarInformacion(email: String){
        
        nombreLabel.text = usuario?.nombre
        apellidoTf.text = "\((usuario?.apellidoPaterno)!) \((usuario?.apellidoMaterno)!)"
        self.email.text = email
        condominioText.text = "Mi condominio:\n\((condominio?.getDireccionCompleta())!)"
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
