//
//  RegistroUsuarioController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 20/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class RegistroUsuarioController: UIViewController, UITextFieldDelegate {
    
    var tipo: String?
    let mailClient = MailClient()
    let generadorContraseñas = GeneradorContrasena()
    @IBOutlet weak var apellidoMaterno: UITextField!
    @IBOutlet weak var apellidoPaterno: UITextField!
    @IBOutlet weak var nombre: UITextField!
    var condominio: Condominio?
    @IBOutlet weak var correo: UITextField!
    var keyboardHeight = CGFloat(220)
    var isEditar = false
    var usuario: UsuarioVisitMe?
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func verificarCampos() -> Bool{
        return nombre.text != "" && apellidoPaterno.text != "" && apellidoMaterno.text != "" && correo.text != ""
        
    }
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func guardar(_ sender: Any) {
        if verificarCampos(){
            if !isEditar{
                if AppDelegate.dbManager.existeCorreo(tabla: tipo!, correo: correo.text!){
                    showAlert(title: "Correo no válido", message: "El correo ya ha sido registrado con otro usuario")
                    return
                }
                let contraseña = generadorContraseñas.generarContrasena()
                AppDelegate.dbManager.registrarUsuario(tabla: tipo!, nombre: nombre.text!, apellidoPaterno: apellidoPaterno.text!, apellidoMaterno: apellidoMaterno.text!, password: contraseña, email: correo.text!)
                
                if tipo! == "RESIDENTE" {
                    AppDelegate.dbManager.registrarResidenteCondominio(condoId: (condominio?.id)!, email: correo.text!)
                }
                else{
                    AppDelegate.dbManager.registrarVigilanteCondominio(condoId: (condominio?.id)!, email: correo.text!)
                }
                enviarMailConfirmacion(email: correo.text!, nombre: nombre.text!, contraseña: contraseña)
                showRegistroAlert(title: "Registro exitoso", message: "Se ha enviado un correo con las credenciales al \((tipo?.lowercased())!)")
            }
            else {
                if (usuario?.email)! != correo.text! && AppDelegate.dbManager.existeCorreo(tabla: tipo!, correo: correo.text!){
                    showAlert(title: "Correo no válido", message: "El correo ya ha sido registrado con otro usuario")
                    return
                }
                if (usuario?.nombre)! != nombre.text!{
                    AppDelegate.dbManager.updateUsuario(tabla: tipo!, atributo: "NOMBRE", dato: nombre.text!, ID: (usuario?.id)!)
                }
                if (usuario?.apellidoMaterno)! != apellidoMaterno.text!{
                    AppDelegate.dbManager.updateUsuario(tabla: tipo!, atributo: "APELLIDO_MATERNO", dato: apellidoMaterno.text!, ID: (usuario?.id)!)
                }
                if (usuario?.apellidoPaterno)! != apellidoPaterno.text!{
                    AppDelegate.dbManager.updateUsuario(tabla: tipo!, atributo: "APELLIDO_PATERNO", dato: apellidoPaterno.text!, ID: (usuario?.id)!)
                }
                
                if (usuario?.email)! != correo.text!{
                    AppDelegate.dbManager.updateUsuario(tabla: tipo!, atributo: "EMAIL", dato: nombre.text!, ID: (usuario?.id)!)
                }
                
                switch tipo! {
                case "RESIDENTE":
                    usuario = AppDelegate.dbManager.cargarResidente(email: correo.text!)
                case "ADMINISTRADOR":
                    usuario = AppDelegate.dbManager.cargarAdmin(email: correo.text!)
                case "VIGILANTE":
                    usuario = AppDelegate.dbManager.cargarVigilante(email: correo.text!)
                default:
                    break
                }
                
                showRegistroAlert(title: "Perfil actualizado", message: "Tu perfil se ha actualizado con éxito")
                
            }
        }
        else{
            showAlert(title: "Datos incompletos", message: "Todos los campos deben estar llenos")
        }
        
    }
    
    func enviarMailConfirmacion(email: String, nombre: String, contraseña: String){
        let mensaje = "<p>Bienvenido a VisitMe, \(nombre).</p><p>El administrador del condominio \((condominio?.getDireccionCompleta())!) te ha registrado como \((tipo?.lowercased())!) para tener el control de visitas dentro del mismo.</p><p>Descarga la aplicación VisitMe en la AppStore e ingresa las siguientes credenciales:</p><p>Usuario: \(email)</p><p>Contraseña: \(contraseña)</p><p>Saludos</p><p>Equipo VisitMe</p>"
        mailClient.enviarMail(mail: email, mensaje: mensaje, asunto: "Registro", nombre: nombre)
    }
    
    @IBAction func moverVista(_ sender: Any) {
        
        if view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardHeight
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setPantallaEditar(){
        isEditar = true
        self.title = "Actualizar"
    }
    
    func showRegistroAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            if self.isEditar{
                let dashboard = self.navigationController?.viewControllers[0] as! DashboardController
                dashboard.usuario = self.usuario
                dashboard.cargarInformacion(email: self.correo.text!)
            }
            
            self.navigationController?.popViewController(animated: true)
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
}
