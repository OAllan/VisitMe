//
//  adminController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 16/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class adminController: UIViewController{
    
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellidoPaterno: UITextField!
    @IBOutlet weak var apellidoMaterno: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var contraseña: UITextField!
    
    var registrarCondo: condoController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboardGuardar: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        registrarCondo = storyboardGuardar.instantiateViewController(withIdentifier: "pantallaCondo") as! condoController
        
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
        return nombre.text != "" && apellidoPaterno.text != "" && apellidoMaterno.text != "" && email.text != "" && contraseña.text != ""
        
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
        let alert = UIAlertController(title: "Registro exitoso", message: "Administrador registrado correctamente", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            let navigationCondo = self.navigationController!
            self.navigationController?.popViewController(animated: true)
            navigationCondo.pushViewController(self.registrarCondo!, animated: true)
            
           
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
  
    @IBAction func cancelar(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pantallaInicial = storyBoard.instantiateViewController(withIdentifier: "pantallaInicial") as! ViewController
       
        present(pantallaInicial, animated: true, completion: nil)
    }
    
}
