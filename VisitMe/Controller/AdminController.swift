//
//  adminController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 16/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class AdminController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidoPaterno: UITextField!
    @IBOutlet weak var apellidoMaterno: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contraseña: UITextField!
    
    
    var registrarCondo: CondoController?
    var keyboardHeight = CGFloat(220)
    var admin: Admin?
    var isBack: Bool?
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboardGuardar: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        registrarCondo = storyboardGuardar.instantiateViewController(withIdentifier: "pantallaCondo") as! CondoController
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        let info:NSDictionary = notification.userInfo! as NSDictionary
        var keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        if keyboardHeight == 220 && keyboardSize.height != 0{
            keyboardHeight = keyboardSize.height - 50
        }
        
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func guardar(_ sender: Any) {
        if verificarCampos(){
            if AppDelegate.dbManager.existeCorreo(tabla: "ADMINISTRADOR", correo: email.text!) {
                showErrorAlert(title: "Correo no válido", message: "El correo ingresado ya está registrado con otro usuario")
                return
            }
            admin = AppDelegate.dbManager.registrarAdmin(nombre: nombre.text!, apellidoPaterno: apellidoPaterno.text!, apellidoMaterno: apellidoMaterno.text!, password: contraseña.text!, email: email.text!)
            
            if admin != nil {
                showSuccessAlert(admin: admin!)
            }
        }
        else{
            showErrorAlert(title: "Datos incompletos", message: "Todos los campos deben estar llenos")
        }
        
    }
    
    func verificarCampos() -> Bool{
        return nombre.text != "" && apellidoPaterno.text != "" && apellidoMaterno.text != "" && email.text != "" && contraseña.text != ""
        
    }
    func showErrorAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    func showSuccessAlert(admin: Admin)
    {
        let alert = UIAlertController(title: "Registro exitoso", message: "Administrador registrado correctamente", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            let navigationCondo = self.navigationController!
            self.registrarCondo?.admin = admin
            navigationCondo.pushViewController(self.registrarCondo!, animated: true)
            
           
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func moverVista(_ sender: Any) {
        
        if view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardHeight
        }
        
    }
    
  
    @IBAction func cancelar(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pantallaInicial = storyBoard.instantiateViewController(withIdentifier: "pantallaInicial") as! ViewController
       
        present(pantallaInicial, animated: true, completion: nil)
    }
    
}
