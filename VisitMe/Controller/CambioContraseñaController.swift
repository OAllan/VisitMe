//
//  CambioContraseñaController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 21/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class CambioContraseñaController: UIViewController, UITextFieldDelegate{
    
    
    var usuario: UsuarioVisitMe?
    var tipo: String?
    var keyboardHeight = CGFloat(220)
    @IBOutlet weak var actual: UITextField!
    @IBOutlet weak var nueva: UITextField!
    @IBOutlet weak var confirmacion: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let info:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        if keyboardHeight == 220 && keyboardSize.height != 0{
            keyboardHeight = keyboardSize.height - 50
        }
        
        
    }
    
    func verificarCampos() -> Bool{
        return actual.text! != "" && nueva.text! != "" && confirmacion.text! != ""
    }
    
    @IBAction func guardar(_ sender: Any) {
        if verificarCampos(){
            if AppDelegate.dbManager.compararPassword(email: (usuario?.email)!, password: actual.text!, tabla: tipo!) {
                if nueva.text! == confirmacion.text!{
                    AppDelegate.dbManager.updateUsuario(tabla: tipo!, atributo: "PASSWORD", dato: nueva.text!, ID: (usuario?.id)!)
                    showSuccessAlert(title: "Actualización existosa", message: "Tu contraseña ha sido cambiada satisfactoriamente")
                }
                else{
                    showAlert(title: "Error", message: "Las contraseñas nuevas no coinciden")
                }
            }
            else{
                showAlert(title: "Error", message: "Contraseña incorrecta")
            }
        }
        else{
            showAlert(title: "Datos incompletos", message: "Todos los campos deben estar llenos")
        }
    }
    
    @IBAction func moverVista(_ sender: Any) {
        
        if view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardHeight/2
        }
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccessAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
}
