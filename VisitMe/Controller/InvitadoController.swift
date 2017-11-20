//
//  InvitadoController.swift
//  VisitMe
//
//  Created by Ángel Andrade García on 14/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit


class InvitadoController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var nombre: UITextField!
    
    @IBOutlet weak var apellidoPaterno: UITextField!
    
    @IBOutlet weak var apellidoMaterno: UITextField!
    
    
    @IBOutlet weak var placas: UITextField!
    
    
    @IBOutlet weak var fecha: UIDatePicker!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var carroSwitch: UISwitch!
    
    var invitadoRegistradoController: InvitadoRegistradoController?
    
    var usuario: Usuario?
    let keyboardHeight: CGFloat = 200
    var cstDate: String?
    let gmtDf: DateFormatter = DateFormatter()
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gmtDf.timeZone = NSTimeZone(name: "CST")! as TimeZone
        gmtDf.dateFormat = "yyyy-MM-dd"
        cstDate = gmtDf.string(from: Date())
        fecha.minimumDate = gmtDf.date(from: cstDate!)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        invitadoRegistradoController = storyBoard.instantiateViewController(withIdentifier: "registrado") as? InvitadoRegistradoController
        if !(invitadoRegistradoController?.isViewLoaded)! {
            invitadoRegistradoController?.loadView()
        }
        
        

    }
    
    @IBAction func guardar(_ sender: Any) {
        if verificarCampos(){
            registrarInvitacion()
        }
        else{
            showErrorAlert()
        }
        
    }
    
    func verificarCampos() -> Bool{
        return nombre.text! != "" && apellidoPaterno.text != "" && apellidoMaterno.text != "" && email.text != ""
    }

    func registrarInvitacion(){
        let codigo = UUID().uuidString
        AppDelegate.dbManager.registrarInvitacion(codigo: codigo, nombre: nombre.text!, apellidoPaterno: apellidoPaterno.text!, apellidoMaterno: apellidoMaterno.text!, placas: self.getAtributoPlacas(), fecha: self.gmtDf.string(from: fecha.date), email: email.text!, usuario: (usuario?.id)!)
        self.invitadoRegistradoController?.invitacion = self.generarInvitado(codigo: codigo)
        showSuccessAlert()
    }
   
    
    func getAtributoPlacas() ->String?{
        if carroSwitch.isOn && placas.text! != "" &&  placas.text! != "Placas"{
            return placas.text
        }
        return nil
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
            self.invitadoRegistradoController?.residente = true
            self.invitadoRegistradoController?.cargarInformacion()
            navigationInvitados.pushViewController(self.invitadoRegistradoController!, animated: true)
            
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func generarInvitado(codigo: String) ->Invitacion? {
        return Invitacion(folio: codigo, idUsuario: (usuario?.id)!, nombres: (nombre.text)!, apellidoPaterno: (apellidoPaterno.text)!, apellidoMaterno: (apellidoMaterno.text)!, placas: self.getAtributoPlacas(), horaEntrada: "0", horaSalida: "0", fechaValida:gmtDf.string(from: fecha.date), esExpirada: false, email: email.text!)
    }
    
    

    
    
    
    
}
