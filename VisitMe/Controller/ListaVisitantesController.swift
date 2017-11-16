//
//  ListaVisitantesController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 15/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit


class ListaVisitantesController: UITableViewController
{
    var residente: Usuario?
    var lista: [Invitacion]?
    var refresher: UIRefreshControl!
    var pantallaInvitacion: InvitadoRegistradoController?

    override func viewDidLoad() {
        super.viewDidLoad()
        lista = AppDelegate.dbManager.cargarVisitantes(residenteId: "1")
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Suelta para actualizar")
        
        refresher.addTarget(self, action: #selector(ListaVisitantesController.actualizarDatos), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        pantallaInvitacion = storyBoard.instantiateViewController(withIdentifier: "registrado") as! InvitadoRegistradoController
        
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pantallaInvitacion?.loadViewIfNeeded()
        pantallaInvitacion?.invitacion = lista?[indexPath.row]
        pantallaInvitacion?.cargarInformacion()
        navigationController?.pushViewController(pantallaInvitacion!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            lista?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    @IBAction func editar(_ sender: Any) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    @objc func actualizarDatos(){
        lista = AppDelegate.dbManager.cargarVisitantes(residenteId: (residente?.id)!)
        self.tableView.reloadData()
        self.refresher.endRefreshing()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destino = segue.destination as! InvitadoController
        destino.usuario = self.residente
    }
}
