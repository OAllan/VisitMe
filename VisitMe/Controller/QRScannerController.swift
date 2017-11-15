//
//  QRScannerController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 26/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import BarcodeScanner

class QRScannerController: BarcodeScannerController, BarcodeScannerCodeDelegate, BarcodeScannerErrorDelegate, BarcodeScannerDismissalDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.codeDelegate = self
        self.errorDelegate = self
        self.dismissalDelegate = self
        BarcodeScanner.Info.loadingText = NSLocalizedString("Buscando invitación...", comment: "")
    }
    
    
    func barcodeScanner(_ controller: BarcodeScannerController, didCaptureCode code: String, type: String) {
        print("Encontrado")
        buscarInvitacion(code: code)
    }
    
    func barcodeScanner(_ controller: BarcodeScannerController, didReceiveError error: Error) {
        print(error)
    }
    
    func barcodeScannerDidDismiss(_ controller: BarcodeScannerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func buscarInvitacion(code: String){
        if let invitacion = AppDelegate.dbManager.buscarCodigo(codigo: code){
            print("Codigo válido")
        }
        else{
            print("No encontrado")
            showAlert()
        }
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Invitación no encontrada", message: "El código leído no existe", preferredStyle: .alert)
        
        
        let ok  = UIAlertAction(title: "Ok", style: .default, handler: { (action) -> Void in
            self.resetWithError(message: "Invitacion no encontrada")
        })
        
        
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}
