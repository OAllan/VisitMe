//
//  VigilanteController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit
import BarcodeScanner

class VigilanteController: UIViewController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate{
    
    @IBOutlet weak var nombreLabel: UILabel!
    @IBOutlet weak var apellidoTf: UILabel!
    @IBOutlet weak var email: UILabel!
    
    let controller = BarcodeScannerController()
    var vigilante: Vigilante? = nil
    
    @IBAction func escanearCodigo(_ sender: Any) {
        controller.reset()
        present(controller, animated: true, completion: nil)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        buscarInvitacion()
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.codeDelegate = self
        controller.errorDelegate = self
        controller.dismissalDelegate = self
    }
    
    func buscarInvitacion(){
        
    }
    
    func cargarInformacion(email: String){
        nombreLabel.text = vigilante?.nombre
        apellidoTf.text = "\(String(describing: vigilante?.apellidoPaterno)) \(String(describing: vigilante?.apellidoMaterno))"
        self.email.text = email
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
