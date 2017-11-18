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

    @IBOutlet weak var botonEditar: UIBarButtonItem!
    
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
       pantallaInvitacion?.residente = true
        pantallaInvitacion?.cargarInformacion()
        
        navigationController?.pushViewController(pantallaInvitacion!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteAlert(indexPath: indexPath)
        }
    }
    
    @IBAction func editar(_ sender: Any) {
        self.tableView.isEditing = !self.tableView.isEditing
        
        if self.tableView.isEditing {
            botonEditar.title = "Listo"
        }
        else {
            botonEditar.title = "Editar"
        }
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
    
    func showDeleteAlert(indexPath: IndexPath){
        let alert = UIAlertController(title: "Confirmar", message: "¿Estás segur@ que deseas eliminar esta invitación?", preferredStyle: .alert)
        
        
        let eliminar  = UIAlertAction(title: "Eliminar", style: .default, handler: { (action) -> Void in
            let invitacion = self.lista?.remove(at: indexPath.row)
            AppDelegate.dbManager.borrarInvitacion(codigoSeleccionado: (invitacion?.folio)!)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) -> Void in
        })
        
        alert.addAction(eliminar)
        alert.addAction(cancelar)
        present(alert, animated: true, completion: nil)
        
        
    }
}
