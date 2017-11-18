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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Champagne & Limousines", size: 26)
        
        label.text = tipoUsuarios[row]
        
        return label
    }
    
    func enviarMail(){
        let session = URLSession.shared
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.mailgun.net/v3/sandboxcfed339b84b54aac889d58b921042503.mailgun.org/messages")! as URL as URL)
        request.httpMethod = "POST"
        let data = "from: Excited User <sandboxcfed339b84b54aac889d58b921042503.mailgun.org>&to: [oscarallan94@gmail.com]&subject:Hello&text:Testinggsome Mailgun awesomness!"
        request.httpBody = data.data(using: String.Encoding.ascii)
        request.setValue("key-f0bbe64b90820d692c8bb7428e4043cb", forHTTPHeaderField: "api")
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            
            if let error = error {
                print(error)
            }
            if let response = response {
                print("url = \(response.url!)")
                print("response = \(response)")
                let httpResponse = response as! HTTPURLResponse
                print("response code = \(httpResponse.statusCode)")
            }
            
            
        })
        task.resume()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        enviarMail()
        if ViewController.dbManager!.compararPassword(email: correoTf.text!, password: contraTf.text!, tabla: (tipo?.uppercased())!){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            switch tipo!{
            case "Vigilante":
                let tabViewController = storyBoard.instantiateViewController(withIdentifier: "tabController") as! UITabBarController
                tabViewController.loadViewIfNeeded()
                let navigationVigilanteViewController = tabViewController.childViewControllers[0] as! UINavigationController
                navigationVigilanteViewController.loadViewIfNeeded()
                let vigilanteViewController = navigationVigilanteViewController.topViewController as! VigilanteController
                vigilanteViewController.loadViewIfNeeded()
                vigilanteViewController.vigilante = ViewController.dbManager?.cargarVigilante(email: correoTf.text!)
                vigilanteViewController.cargarInformacion(email: correoTf.text!)
                self.present(tabViewController, animated: true, completion: nil)
            case "Residente":
                let tabViewController = storyBoard.instantiateViewController(withIdentifier: "tabResidenteController") as! UITabBarController
                tabViewController.loadViewIfNeeded()
                let navigationController = tabViewController.childViewControllers[1] as! UINavigationController
                let navigationControllerResidente = tabViewController.childViewControllers[0] as! UINavigationController
                navigationControllerResidente.loadViewIfNeeded()
                let residenteViewController = navigationControllerResidente.topViewController as! DashboardController
                residenteViewController.loadViewIfNeeded()
                navigationController.loadViewIfNeeded()
                let listaInvitadosController = navigationController.topViewController as! ListaVisitantesController
                
                let residente = ViewController.dbManager?.cargarResidente(email: correoTf.text!)
                listaInvitadosController.residente = residente
                residenteViewController.residente = residente
                residenteViewController.cargarInformacion(email: correoTf.text!)
                listaInvitadosController.actualizarDatos()
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
