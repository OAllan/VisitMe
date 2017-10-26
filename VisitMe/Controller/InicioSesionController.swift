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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        contraTf.delegate = self
        correoTf.delegate = self
        ViewController.dbManager?.registrarResidente(nombre: "Aldo", apellidoPaterno: "Aguilar", apellidoMaterno: "Bermudez", password: "test", email: "aldo@mail.com")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
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
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        if ViewController.dbManager!.compararPassword(email: correoTf.text!, password: contraTf.text!, tabla: (tipo?.uppercased())!){
            switch tipo!{
            case "Vigilante":
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabViewController = storyBoard.instantiateViewController(withIdentifier: "tabController") as! UITabBarController
                tabViewController.loadViewIfNeeded()
                
                let vigilanteViewController = tabViewController.childViewControllers[0] as! VigilanteController
                vigilanteViewController.loadViewIfNeeded()
                vigilanteViewController.vigilante = ViewController.dbManager?.cargarVigilante(email: correoTf.text!)
                vigilanteViewController.cargarInformacion(email: correoTf.text!)
                self.present(tabViewController, animated: true, completion: nil)
            case "Residente":
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let tabViewController = storyBoard.instantiateViewController(withIdentifier: "tabResidenteController") as! UITabBarController
                tabViewController.loadViewIfNeeded()
                let residenteViewController = tabViewController.childViewControllers[0] as! ResidenteController
                residenteViewController.loadViewIfNeeded()
                residenteViewController.residente = ViewController.dbManager?.cargarResidente(email: correoTf.text!)
                residenteViewController.cargarInformacion(email: correoTf.text!)
                self.present(tabViewController, animated: true, completion: nil)
            case "Admnistrador":
                print(".")
            default:
                break
            }
            
        }
        else{
            showAlert()
        }
        
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Error al iniciar sesion", message: "Usuario, contraseña o tipo de usuario incorrecto", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}
