//
//  condoController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 16/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class CondoController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var botonGuardar: UIBarButtonItem!
    @IBOutlet weak var calle: UITextField!
    @IBOutlet weak var colonia: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var codigoPostal: UITextField!
    @IBOutlet weak var estado: UITextField!
    @IBOutlet weak var delegacion: UITextField!
    
    var admin: Admin?
    var perfilAdmin: UITabBarController?
    var keyboardHeight = CGFloat(220)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        let storyBoardGuardar: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        perfilAdmin = storyBoardGuardar.instantiateViewController(withIdentifier: "superPerfilAdmin") as! UITabBarController
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    
    @IBAction func guardar(_ sender: Any) {
        if verificarCampos(){
            if !verificarCP(){
                showErrorAlert(title: "Código Postal no válido", message: "El código postal debe tener 5 digitos")
                return
            }
            AppDelegate.dbManager.registrarCondo(admin: (admin?.id)!, calle: calle.text!, numero: numero.text!, colonia: colonia.text!, cp: codigoPostal.text!, ciudad: delegacion.text!, estado: estado.text!)
            showSuccessAlert()
        }
        else{
            showErrorAlert(title: "Datos incompletos", message: "Todos los campos deben estar llenos")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func moverVista(_ sender: Any) {
        
        if view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardHeight
        }
        
    }
    
    
    func verificarCampos() -> Bool{
        return calle.text != "" && colonia.text != "" && numero.text != "" && codigoPostal.text != "" && estado.text != "" && delegacion.text != ""
    }
    
    func verificarCP() -> Bool {
        return codigoPostal.text?.count == 5
    }
    
    func showErrorAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func showSuccessAlert()
    {
        let alert = UIAlertController(title: "Registro exitoso", message: "Condominio registrado correctamente", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.perfilAdmin?.loadViewIfNeeded()
            let navigation = self.perfilAdmin?.childViewControllers[0] as! UINavigationController
            navigation.loadViewIfNeeded()
            let dashboardController = navigation.topViewController as! DashboardController
            dashboardController.loadViewIfNeeded()
            dashboardController.type = "ADMINISTRADOR"
            let condominio = AppDelegate.dbManager.cargarAdminCondominio(adminId: (self.admin?.id)!)
            let residentesNavigationController = self.perfilAdmin?.childViewControllers[2] as! UINavigationController
            residentesNavigationController.loadViewIfNeeded()
            let vigilantesNavigationController = self.perfilAdmin?.childViewControllers[1] as! UINavigationController
            vigilantesNavigationController.loadViewIfNeeded()
            let listaVigilantesController = vigilantesNavigationController.topViewController as! ListaVigilantesController
            let listaResidentesController = residentesNavigationController.topViewController as! ListaResidentesController
            listaVigilantesController.loadViewIfNeeded()
            listaResidentesController.loadViewIfNeeded()
            listaResidentesController.condominio = condominio
            listaVigilantesController.condominio = condominio
            listaResidentesController.admin = self.admin
            listaVigilantesController.admin = self.admin
            dashboardController.usuario = self.admin
            dashboardController.condominio = condominio
            listaVigilantesController.actualizarDatos()
            listaResidentesController.actualizarDatos()
            dashboardController.cargarInformacion(email: (self.admin?.email)!)
            self.present(self.perfilAdmin!, animated: true, completion: nil)
            
            
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pantallaAdmin = storyBoard.instantiateViewController(withIdentifier: "registrarAdmin") as! AdminController
        
        present(pantallaAdmin, animated: true, completion: nil)
    }
    
}
