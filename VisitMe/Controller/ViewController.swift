//
//  ViewController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 24/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dbManager = DBManager()
        dbManager.abrirBaseDeDatos()
        dbManager.crearTablas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
