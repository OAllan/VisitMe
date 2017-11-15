//
//  InvitadoRegistradoController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 14/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit


class InvitadoRegistradoController: UIViewController{
    
    @IBOutlet weak var imagenQROutlet: UIImageView!
    var imagenQR: UIImage?
    var documentInteractionController = UIDocumentInteractionController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func enviarPorWhatsapp(_ sender: Any) {
        
        if (imagenQR != nil)  {
            if let imageData = UIImageJPEGRepresentation(imagenQR!, 1.0) {
                let tempFile = URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.jpg")
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
    
}
