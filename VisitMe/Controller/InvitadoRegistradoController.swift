//
//  InvitadoRegistradoController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 14/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

import QRCode

class InvitadoRegistradoController: UIViewController{
    
    @IBOutlet weak var imagenQROutlet: UIImageView!
    var imagenQR: UIImage?
    var documentInteractionController = UIDocumentInteractionController()
    var invitacion: Invitacion?
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var apellidos: UILabel!
    @IBOutlet weak var fecha: UILabel!
    
    @IBOutlet weak var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cargarInformacion(){
        nombre.text = invitacion?.getNombres()
        apellidos.text = "\((invitacion?.apellidoPaterno)!) \((invitacion?.apellidoMaterno)!)"
        email.text = invitacion?.getEmail()
        fecha.text = "Fecha de visita: \((parsearFecha())!)"
        generarCodigoQR()
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
        
        return "\(componentes![2]) de \(mes) del \(componentes![1])"
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
        let imageQR = QRCode((invitacion?.idUsuario)!)
        imagenQR = imageQR?.image
        imagenQROutlet.image = imagenQR
    }
    
}
