//
//  InvitadoRegistradoController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 14/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit
import MessageUI
import QRCode

class InvitadoRegistradoController: UIViewController, MFMailComposeViewControllerDelegate{
    @IBOutlet weak var botonesResidente: UIStackView!
    
    @IBOutlet weak var botonesVigilante: UIStackView!
    @IBOutlet weak var imagenQROutlet: UIImageView!
    var imagenQR: UIImage?
    var documentInteractionController = UIDocumentInteractionController()
    var invitacion: Invitacion?
    var residente : Bool?
    
    @IBOutlet weak var estado: UILabel!
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var apellidos: UILabel!
    @IBOutlet weak var fecha: UILabel!
    var cstDate: String?
    let gmtDf: DateFormatter = DateFormatter()
    
    @IBOutlet weak var placas: UILabel!
    @IBOutlet weak var carro: UILabel!
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        gmtDf.timeZone = NSTimeZone(name: "CST")! as TimeZone
        gmtDf.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
    }
    
    @IBAction func sendMail(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
                present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([(invitacion?.email)!])
        mailComposerVC.setSubject("Invitación VisitMe")
        mailComposerVC.setMessageBody("<p>Hola, \((invitacion?.nombres)!).</p><p>Favor de traer contigo el siguiente código QR, será tu acceso al condominio. Para proteger el medio ambiente, te recomendamos traerlo en tu celular o dispositivo de preferencia.</p>", isHTML: true)
        let imageData = UIImagePNGRepresentation(imagenQR!)
        mailComposerVC.addAttachmentData(imageData!, mimeType: "image/png", fileName: "codigoqr.png")
        
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cargarInformacion(){
        nombre.text = invitacion?.getNombres()
        apellidos.text = "\((invitacion?.apellidoPaterno)!) \((invitacion?.apellidoMaterno)!)"
        email.text = invitacion?.getEmail()
        fecha.text = "Fecha de visita: \((parsearFecha())!)"
        if invitacion?.placas != "<null>"{
            carro.text = "Carro: SI"
            placas.text = "Placas: \((invitacion?.placas)!)"
        }
        else{
            carro.text = "Carro: NO"
            placas.text = "Placas: N/A"
        }
        generarCodigoQR()
        let activa: String?
        if (invitacion?.esExpirada)!{
            activa = "Expirada"
            estado.textColor = .red
        }
        else {
            activa = "Activa"
            estado.textColor = .green
        }
        estado.text = "Estado: \(activa!)"
        botonesVigilante.isHidden = residente!
        botonesResidente.isHidden = !(residente!)
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        if self.isMovingFromParentViewController && !residente! {
            let scannerController  = navigationController?.viewControllers[0] as! QRScannerController
            scannerController.reset()
        }
    }
    
    func parsearFecha() -> String?{
        let componentes = invitacion?.getFechaValida().split(separator: "-")
        var mes = ""
        switch componentes![1] {
        case "1":
            mes = "enero"
        case "2":
            mes = "febrero"
        case "3":
            mes = "marzo"
        case "4":
            mes = "abril"
        case "5":
            mes = "mayo"
        case "6":
            mes = "junio"
        case "7":
            mes = "julio"
        case "8":
            mes = "agosto"
        case "9":
            mes = "septiembre"
        case "10":
            mes = "octubre"
        case "11":
            mes = "noviembre"
        case "12":
            mes = "diciembre"
        default:
            mes = ""
        }
        
        return "\(componentes![2]) de \(mes) del \(componentes![0])"
    }
    
    
    @IBAction func registrarEntrada(_ sender: Any) {
        if (invitacion?.horaEntrada)! == "0000-00-00 00:00:00" {
            let timestamp = self.gmtDf.string(from: Date())
            AppDelegate.dbManager.updateInvitacion(codigo: (invitacion?.folio)!, atributo: "HORA_ENTRADA", dato: timestamp)
            invitacion?.horaEntrada = timestamp
            showAlert(title: "Registro exitoso", message: "Hora de entrada registrada")
        }
        else{
            showAlert(title: "Error", message: "La hora de entrada ya ha sido registrada")
        }
        
        
    }
    
    @IBAction func registrarSalida(_ sender: Any) {
        if (invitacion?.horaEntrada)! != "0000-00-00 00:00:00"{
            if (invitacion?.horaSalida)! == "0000-00-00 00:00:00"{
                let timestamp = self.gmtDf.string(from: Date())
                AppDelegate.dbManager.updateInvitacion(codigo: (invitacion?.folio)!, atributo: "HORA_SALIDA", dato: timestamp)
                AppDelegate.dbManager.updateInvitacion(codigo: (invitacion?.folio)!, atributo: "EXPIRADA", dato: "1")
                invitacion?.horaSalida = timestamp
                invitacion?.esExpirada = true
                self.cargarInformacion()
                showAlert(title: "Registro exitoso", message: "Hora de entrada registrada")
            }
            else{
                showAlert(title: "Error", message: "La hora de salida ya ha sido registrada")
            }
        }
        else{
            showAlert(title: "Error", message: "No se ha registrado hora de entrada")
        }
    }
    
    
    func showAlert(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.cargarInformacion()
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func enviarPorWhatsapp(_ sender: Any) {
        
        if (imagenQR != nil)  {
            if let imageData = UIImageJPEGRepresentation(imagenQR!, 1.0) {
                let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/codigoqr.jpg")
                do {
                    try imageData.write(to: tempFile, options: .atomic)
                    self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                    self.documentInteractionController.uti = "image"
                    
                    self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
                        
                    } catch {
                        print(error)
                    }
                }
            }
            
            
            
        
        
    }
    
    func generarCodigoQR(){
        let imageQR = QRCode((invitacion?.folio)!)
        imagenQR = imageQR?.image
        imagenQROutlet.image = imagenQR
    }
    
}
