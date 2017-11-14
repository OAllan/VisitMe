//
//  QRGeneratorController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 13/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit
import QRCode
import MongoLabKitSwift


class QRGeneratorController: UIViewController
{
    @IBOutlet weak var imagenQR: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let qrCode = QRCode("12345678901213jd")
        imagenQR.image = qrCode?.image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
