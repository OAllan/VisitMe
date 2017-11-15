//
//  InvitadoController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 14/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit
import QRCode

class InvitadoController: UIViewController{
    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var apellidoPaterno: UITextField!
    
    @IBOutlet weak var apellidoMaterno: UITextField!
    
    
    @IBOutlet weak var placas: UITextField!
    
    
    @IBOutlet weak var fecha: UIDatePicker!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var carroSwitch: UISwitch!
    
    var invitadoRegistradoController: InvitadoRegistradoController?
    
    var usuario: Usuario?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fecha.minimumDate = Date()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        invitadoRegistradoController = storyBoard.instantiateViewController(withIdentifier: "registrado") as? InvitadoRegistradoController
        if !(invitadoRegistradoController?.isViewLoaded)! {
            invitadoRegistradoController?.loadView()
        }
    }
    
    @IBAction func guardar(_ sender: Any) {
        if verificarCampos(){
            showSuccessAlert()
        }
        else{
            showErrorAlert()
        }
        
    }
    
    func verificarCampos() -> Bool{
        return nombre.text! != "" && apellidoPaterno.text != "" && apellidoMaterno.text != "" && email.text != ""
    }
   
    
    
    
    @IBAction func carroBool(_ sender: UISwitch) {
       
        if carroSwitch.isOn{
            placas.isEnabled = true
            placas.isHidden = false
        }else{
            placas.isEnabled = false
            placas.isHidden = true
            if(placas.text! == ""){
                placas.text = "Placas"
                placas.textColor = UIColor.gray
            }
        }
    
    }
    
    
    @IBAction func placasTexto(_ sender: UITextField) {
        if placas.isEnabled == true && placas.text?.contains("Placas") == true{
            placas.text = ""
            placas.textColor = UIColor.black
        }
    }
    
    func showErrorAlert()
    {
        let alert = UIAlertController(title: "Datos incompletos", message: "Todos los campos deben estar llenos", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccessAlert()
    {
        let alert = UIAlertController(title: "Registro exitoso", message: "Invitado registrado correctamente", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            let navigationInvitados = self.navigationController!
            self.navigationController?.popViewController(animated: true)
            self.invitadoRegistradoController?.imagenQR = self.generarCodigo()
            navigationInvitados.pushViewController(self.invitadoRegistradoController!, animated: true)
            
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    func generarCodigo() -> UIImage?{
        let qrCode = QRCode("12345678901213jd")
        self.invitadoRegistradoController?.imagenQROutlet.image = qrCode?.image
        return qrCode?.image
    }
    
    
    
    
    
    
}
