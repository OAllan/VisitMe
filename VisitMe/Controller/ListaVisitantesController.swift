//
//  ListaVisitantesController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 15/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit


class ListVisitantesController: UITableViewController
{
    var residente: Usuario?
    var lista: [Invitacion]?

    override func viewDidLoad() {
        super.viewDidLoad()
        lista = AppDelegate.dbManager.cargarVisitantes(residenteId: "1")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lista?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let invitacion = lista![indexPath.row]
        let nombre = invitacion.getNombres()
        let apellidos = "\(invitacion.getApellidoPaterno()) \(invitacion.getApellidoMaterno())"
        cell.textLabel!.text = nombre
        cell.detailTextLabel!.text = apellidos
        
        return cell
    }
}
