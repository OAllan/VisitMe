//
//  condoController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 16/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class condoController: UIViewController{
    
    
    @IBOutlet weak var calle: UITextField!
    @IBOutlet weak var colonia: UITextField!
    @IBOutlet weak var numero: UITextField!
    @IBOutlet weak var codigoPostal: UITextField!
    @IBOutlet weak var estado: UITextField!
    @IBOutlet weak var delegacion: UITextField!
    
    var perfilAdmin: UITabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyBoardGuardar: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        perfilAdmin = storyBoardGuardar.instantiateViewController(withIdentifier: "superPerfilAdmin") as! UITabBarController

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
        return calle.text != "" && colonia.text != "" && numero.text != "" && codigoPostal.text != "" && estado.text != "" && delegacion.text != ""
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
            let navigationPerfilAd = self.navigationController!

            self.present(self.perfilAdmin!, animated: true, completion: nil)
            
            
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelar(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let pantallaAdmin = storyBoard.instantiateViewController(withIdentifier: "registrarAdmin") as! adminController
        
        present(pantallaAdmin, animated: true, completion: nil)
    }
    
}
