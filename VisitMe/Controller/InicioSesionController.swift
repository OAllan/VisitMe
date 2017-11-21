//
//  InicioSesionController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit


class InicioSesionController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var contraTf: UITextField!
    @IBOutlet weak var correoTf: UITextField!
    let keyboardHeight: CGFloat = 200
    var tipo: String? = "Residente"
    let tipoUsuarios = ["Residente", "Vigilante" ,"Administrador"]
    var mailClient : MailClient?
    let generadorContra = GeneradorContrasena()
    @IBOutlet weak var reestablecer: UIButton!
    @IBOutlet weak var olvide: UIButton!
    @IBOutlet weak var inicio: UIButton!
    @IBOutlet weak var regresar: UIButton!
    
    @IBOutlet weak var contrasenaLabel: UILabel!
    @objc func keyboardWillShow(notification: NSNotification) {
    
        if view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardHeight
        }
       
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func reestablecerContra(_ sender: Any) {
        mostrarReestablecer()
    }
    
    @IBAction func inicio(_ sender: Any) {
        mostrarInicioDeSesion()
    }
    
    
    func mostrarReestablecer() {
        reestablecer.isHidden = false
        inicio.isHidden = true
        olvide.isHidden = true
        regresar.isHidden = false
        contraTf.isHidden = true
        contrasenaLabel.isHidden = true
    }
    
    func mostrarInicioDeSesion(){
        reestablecer.isHidden = true
        inicio.isHidden = false
        olvide.isHidden = false
        regresar.isHidden = true
        contraTf.isHidden = false
        contrasenaLabel.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        contraTf.delegate = self
        correoTf.delegate = self
        reestablecer.isHidden = true
        inicio.isHidden = false
        olvide.isHidden = false
        regresar.isHidden = true
        contraTf.isHidden = false
        contrasenaLabel.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @IBAction func mostrarCampos(_ sender: Any) {
        
        let textField = sender as! UITextField
        
        
        
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tipoUsuarios.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tipoUsuarios[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipo = tipoUsuarios[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Champagne & Limousines", size: 26)
        
        label.text = tipoUsuarios[row]
        
        return label
    }
    
    
    @IBAction func reestablecerContrasena(_ sender: Any) {
        var usuario: UsuarioVisitMe?
        switch tipo! {
        case "Vigilante":
            usuario = AppDelegate.dbManager.cargarVigilante(email: correoTf.text!)
        case "Administrador":
            usuario = AppDelegate.dbManager.cargarAdmin(email: correoTf.text!)
        case "Residente":
            usuario = AppDelegate.dbManager.cargarResidente(email: correoTf.text!)
        default:
            usuario = nil
        }
        
        if usuario != nil{
            let nueva = generadorContra.generarContrasena()
            let mensaje = "<p>Hola, \((usuario?.nombre)!).</p><p>Tu nueva contraseña es: \(nueva)</p><p>Saludos.</p><p>Equipo VisitMe.</p>"
            mailClient = MailClient()
            mailClient?.enviarMail(mail: correoTf.text!, mensaje: mensaje, asunto: "Reestablecer Contraseña", nombre: (usuario?.nombre)!)
            AppDelegate.dbManager.updateUsuario(tabla: tipo!.uppercased(), atributo: "PASSWORD", dato: nueva, ID: (usuario?.id)!)
            showAlert(title: "Correo enviado", message: "Se ha enviado una contraseña temporal a tu correo")
        }
        else{
            showAlert(title: "Usuario no registrado", message: "Correo no existente")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func iniciarSesion(_ sender: Any) {
        if !AppDelegate.isConnectedToNetwork(){
            showAlert(title: "Error", message: "No hay conexión a internet")
            return
        }
        
        if ViewController.dbManager!.compararPassword(email: correoTf.text!, password: contraTf.text!, tabla: (tipo?.uppercased())!){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let tabViewController = siguienteTabController(tipo: tipo!, storyBoard: storyBoard)
            tabViewController?.loadViewIfNeeded()
            let navigationControllerUsuarioVisitMe = tabViewController?.childViewControllers[0] as! UINavigationController
            navigationControllerUsuarioVisitMe.loadViewIfNeeded()
            let dashboardController = navigationControllerUsuarioVisitMe.topViewController as! DashboardController
            dashboardController.loadViewIfNeeded()
            dashboardController.type = tipo?.uppercased()
            
            switch tipo!{
            case "Vigilante":
                let vigilante = ViewController.dbManager?.cargarVigilante(email: correoTf.text!)
                dashboardController.usuario = vigilante
                let condominio = AppDelegate.dbManager.cargarVigilanteCondominio(id: (vigilante?.id)!)
               dashboardController.condominio = condominio
                
            case "Residente":
                let residentesNavigationController = tabViewController?.childViewControllers[1] as! UINavigationController
                residentesNavigationController.loadViewIfNeeded()
                let residente = ViewController.dbManager?.cargarResidente(email: correoTf.text!)
                let condominio = AppDelegate.dbManager.cargarResidenteCondominio(id: (residente?.id)!)
                let listaInvitadosController = residentesNavigationController.topViewController as! ListaVisitantesController
                listaInvitadosController.loadViewIfNeeded()
                listaInvitadosController.residente = residente
                dashboardController.usuario = residente
                dashboardController.condominio = condominio
                listaInvitadosController.actualizarDatos()
            case "Administrador":
                let admin = AppDelegate.dbManager.cargarAdmin(email: correoTf.text!)
                let condominio = AppDelegate.dbManager.cargarAdminCondominio(adminId: (admin?.id)!)
                let residentesNavigationController = tabViewController?.childViewControllers[3] as! UINavigationController
                residentesNavigationController.loadViewIfNeeded()
                let vigilantesNavigationController = tabViewController?.childViewControllers[2] as! UINavigationController
                vigilantesNavigationController.loadViewIfNeeded()
                let listaVigilantesController = vigilantesNavigationController.topViewController as! ListaVigilantesController
                let listaResidentesController = residentesNavigationController.topViewController as! ListaResidentesController
                listaVigilantesController.loadViewIfNeeded()
                listaResidentesController.loadViewIfNeeded()
                listaResidentesController.condominio = condominio
                listaVigilantesController.condominio = condominio
                listaResidentesController.admin = admin
                listaVigilantesController.admin = admin
                dashboardController.usuario = admin
                dashboardController.condominio = condominio
                listaVigilantesController.actualizarDatos()
                listaResidentesController.actualizarDatos()
            default:
                break
            }
            
            dashboardController.cargarInformacion(email: correoTf.text!)
            self.present(tabViewController!, animated: true, completion: nil)
            
            
        }
        else{
            showAlert(title: "Error al iniciar sesión", message: "Usuario, contraseña o tipo de usuario incorrecto")
            
        }
        
    }
    
    func siguienteTabController(tipo: String, storyBoard : UIStoryboard) -> UITabBarController?{
        switch tipo {
        case "Vigilante":
            return storyBoard.instantiateViewController(withIdentifier: "tabController") as! UITabBarController
        case "Residente":
            return storyBoard.instantiateViewController(withIdentifier: "tabResidenteController") as! UITabBarController
        case "Administrador":
            return storyBoard.instantiateViewController(withIdentifier: "superPerfilAdmin") as! UITabBarController
        default:
            return nil
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
    
    
    
    
}
