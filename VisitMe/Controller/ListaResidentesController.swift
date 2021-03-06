//
//  ListaResidentesController.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 20/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import UIKit

class ListaResidentesController : UITableViewController {
    
    var lista: [Usuario]?
    var refresher: UIRefreshControl!
    var condominio: Condominio?
    var admin : Admin?
    var pantallaRegistro: RegistroUsuarioController?
    
    @IBOutlet weak var botonEditar: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lista = []
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Suelta para actualizar")
        
        refresher.addTarget(self, action: #selector(ListaVisitantesController.actualizarDatos), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(refresher)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        pantallaRegistro = storyBoard.instantiateViewController(withIdentifier: "reg") as! RegistroUsuarioController
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (lista?.count)!
    }
    
    @IBAction func agregarResidente(_ sender: Any) {
        
        pantallaRegistro?.loadViewIfNeeded()
        pantallaRegistro?.condominio = condominio
        pantallaRegistro?.tipo = "RESIDENTE"
        self.navigationController?.pushViewController(pantallaRegistro!, animated: true)
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellResidentes", for: indexPath)
        let residente = lista![indexPath.row]
        let nombre = residente.nombre
        let apellidos = "\(residente.apellidoPaterno!) \(residente.apellidoMaterno!)"
        cell.textLabel!.text = nombre
        cell.detailTextLabel!.text = apellidos
        
        return cell
    }
    
    @objc func actualizarDatos(){
    
        lista = AppDelegate.dbManager.cargarResidentes(condoId: (condominio?.id)!)
        self.tableView.reloadData()
        self.refresher.endRefreshing()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteAlert(indexPath: indexPath)
        }
    }
    
    func showDeleteAlert(indexPath: IndexPath){
        let alert = UIAlertController(title: "Confirmar", message: "¿Estás segur@ que deseas eliminar al residente?", preferredStyle: .alert)
        
        
        let eliminar  = UIAlertAction(title: "Eliminar", style: .default, handler: { (action) -> Void in
            let residente = self.lista?.remove(at: indexPath.row)
            AppDelegate.dbManager.borrarResidente(idSeleccionada: (residente?.id)!)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        })
        
        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel, handler: { (action) -> Void in
        })
        
        alert.addAction(eliminar)
        alert.addAction(cancelar)
        present(alert, animated: true, completion: nil)
        
        
    }
}
