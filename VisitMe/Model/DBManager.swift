//
//  DBManager.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 25/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation
import OHMySQL

class DBManager{
    
    var baseDatos: OpaquePointer? = nil
    var context: OHMySQLQueryContext?
    
    func conectar(){
        let client = OHMySQLUser(userName: "sql3204932", password: "nIE6elrb66", serverName: "sql3.freemysqlhosting.net", dbName: "sql3204932", port: 3306, socket: nil)
        let coordinator = OHMySQLStoreCoordinator(user: client!)
        coordinator.encoding = .UTF8MB4
        coordinator.connect()
        context = OHMySQLQueryContext()
        context?.storeCoordinator = coordinator
    }
    
   
    func registrarInvitacion(codigo: String, nombre: String, apellidoPaterno: String, apellidoMaterno: String, placas: String?, fecha: String, email: String, usuario: String) {
        let query = OHMySQLQueryRequestFactory.insert("INVITACION", set: ["CODIGO": codigo, "USUARIO": usuario, "NOMBRE": nombre, "APELLIDO_PATERNO": apellidoPaterno, "APELLIDO_MATERNO": apellidoMaterno, "EMAIL": email, "FECHA_VISITA": fecha, "PLACAS": placas ?? nil])
            try? context?.execute(query)
        
    }
    
    func registrarVigilante(nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        
        self.registrarUsuario(tabla: "VIGILANTE", nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, password: password, email: email)
        
    }
    
    func registrarResidente(nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        self.registrarUsuario(tabla: "RESIDENTE", nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, password: password, email: email)
        
    }
    
    func updateVigilante(atributoSeleccionado: String, datoActualizado: String, idActualizada: String){
        self.updateUsuario(tabla: "VIGILANTE", atributo: atributoSeleccionado.uppercased(), dato: datoActualizado, ID: idActualizada)
    }
    
    func updateAdministrador(atributoSeleccionado: String, datoActualizado: String, idActualizada: String){
        self.updateUsuario(tabla: "ADMINISTRADOR", atributo: atributoSeleccionado.uppercased(), dato: datoActualizado, ID: idActualizada)
    }
    
    func updateResidente(atributoSeleccionado: String, datoActualizado: String, idActualizada: String){
        self.updateUsuario(tabla: "RESIDENTE", atributo: atributoSeleccionado.uppercased(), dato: datoActualizado, ID: idActualizada)
    }
    
    func updateUsuario(tabla: String, atributo: String, dato: String, ID: String) {
        let condicionBusqueda: String = "ID=" + ID
        let query = OHMySQLQueryRequestFactory.update(tabla, set: [atributo: dato], condition: condicionBusqueda)
        try? context?.execute(query)
    }

    func updateInvitacion(codigo: String, atributo: String, dato: String){
        let condicionBusqueda: String = "CODIGO=" + codigo
        let query = OHMySQLQueryRequestFactory.update("INVITACION", set: [atributo.uppercased(): dato], condition: condicionBusqueda)
        try? context?.execute(query)
    }
        
    func borrarAdmin(idSeleccionada: String){
        self.borrarRegistro(tabla: "ADMINISTRADOR", ID: idSeleccionada)
    }
    
    func borrarResidente(idSeleccionada: String){
        self.borrarRegistro(tabla: "RESIDENTE", ID: idSeleccionada)
    }
    
    func borrarVigilante(idSeleccionada: String){
        self.borrarRegistro(tabla: "VIGILANTE", ID: idSeleccionada)
    }
    
    func borrarInvitacion(codigoSeleccionado: String){
        let condicionBusqueda: String = "CODIGO= '\(codigoSeleccionado)'"
        let query = OHMySQLQueryRequestFactory.delete("INVITACION", condition: condicionBusqueda)
        try? context?.execute(query)
    }
    
    func borrarRegistro(tabla: String, ID: String){
        let condicionBusqueda: String = "ID= '\(ID)'"
        let query = OHMySQLQueryRequestFactory.delete(tabla, condition: condicionBusqueda)
        try? context?.execute(query)
    }
    
    func registrarAdmin(nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        self.registrarUsuario(tabla: "ADMINISTRADOR", nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, password: password, email: email)
        
    }
    
    func registrarUsuario(tabla: String, nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        let query = OHMySQLQueryRequestFactory.insert(tabla, set: ["NOMBRE": nombre, "APELLIDO_PATERNO": apellidoPaterno, "APELLIDO_MATERNO": apellidoMaterno, "EMAIL": email, "PASSWORD": password])
        try? context?.execute(query)
    }
    
    func cargarVigilante(email: String) -> Vigilante? {
        let query = OHMySQLQueryRequestFactory.select("VIGILANTE", condition: "EMAIL= '\(email)'")
        let response = (try? context?.executeQueryRequestAndFetchResult(query))!![0]
        return Vigilante(id: "\(response["ID"] as! NSNumber)", nombre: response["NOMBRE"] as! String, apellidoPaterno: response["APELLIDO_PATERNO"] as! String, apellidoMaterno: response["APELLIDO_MATERNO"] as! String, email: response["EMAIL"] as! String)
    }
    
    func cargarResidente(email: String) -> Usuario? {
        let query = OHMySQLQueryRequestFactory.select("RESIDENTE", condition: "EMAIL= '\(email)'")
        let response = (try? context?.executeQueryRequestAndFetchResult(query))!![0]
        return Usuario(id: "\(response["ID"] as! NSNumber)", nombre: response["NOMBRE"] as! String, apellidoPaterno: response["APELLIDO_PATERNO"] as! String, apellidoMaterno: response["APELLIDO_MATERNO"] as! String, email: response["EMAIL"] as! String)
    }
    
    func cargarAdmin(email: String) -> Admin? {
        let query = OHMySQLQueryRequestFactory.select("ADMINISTRADOR", condition: "EMAIL= '\(email)'")
        let response = (try? context?.executeQueryRequestAndFetchResult(query))!![0]
        return Admin(id: "\(response["ID"] as! NSNumber)", nombre: response["NOMBRE"] as! String, apellidoPaterno: response["APELLIDO_PATERNO"] as! String, apellidoMaterno: response["APELLIDO_MATERNO"] as! String, email: response["EMAIL"] as! String)
    }
    
    func compararPassword(email: String, password: String, tabla: String) ->Bool {
        
        let query = OHMySQLQueryRequestFactory.select(tabla, condition: "EMAIL= '\(email)'")
        let response = (try? context?.executeQueryRequestAndFetchResult(query))!!
        if response.count <= 0{
            return false;
        }
        let data = response[0]
        let pass = data["PASSWORD"] as! String
        if pass == password{
            return true;
        }
        
        return false;
    }
    
    func buscarCodigo(codigo: String) -> Invitacion? {
        let query = OHMySQLQueryRequestFactory.select("INVITACION", condition: "CODIGO= '\(codigo)'")
        let response = (try? context?.executeQueryRequestAndFetchResult(query))!!
        if response.count <= 0{
            return nil
        }
        let data = response[0]
        let usuario = "\(data["USUARIO"] as! NSNumber)"
        let nombre = data["NOMBRE"] as! String
        let apellidoPaterno = data["APELLIDO_PATERNO"] as! String
        let apellidoMaterno = data["APELLIDO_MATERNO"] as! String
        let placas = data["PLACAS"] as? String
        let horaEntrada = data["HORA_ENTRADA"] as! String
        let horaSalida = data["HORA_ENTRADA"] as! String
        let expirada = data["EXPIRADA"] as! String
        let email = data["EMAIL"] as! String
        let fecha = data["FECHA_VISITA"] as! String
        
        return Invitacion(folio: codigo, idUsuario: usuario, nombres: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, placas: placas, horaEntrada: horaEntrada, horaSalida: horaSalida, fechaValida: fecha, esExpirada: expirada == "1", email: email)
        
    }
    
    func cargarVisitantes(residenteId: String) -> [Invitacion]?{
        let query = OHMySQLQueryRequestFactory.select("INVITACION", condition: "USUARIO= \(residenteId)")
        let response = (try? context?.executeQueryRequestAndFetchResult(query))!!
        if response.count <= 0{
            return nil
        }
        return self.toArrayVisitantes(dict: response)
    }
    
    func toArrayVisitantes(dict: [[String:Any?]]) ->[Invitacion]?{
        var visitantes: [Invitacion] = []
        for data in dict {
            let codigo = data["CODIGO"] as! String
            let usuario = "\(data["USUARIO"] as! NSNumber)"
            let nombre = data["NOMBRE"] as! String
            let apellidoPaterno = data["APELLIDO_PATERNO"] as! String
            let apellidoMaterno = data["APELLIDO_MATERNO"] as! String
            let placas = data["PLACAS"] as? String
            let horaEntrada = data["HORA_ENTRADA"] as! String
            let horaSalida = data["HORA_ENTRADA"] as! String
            let expirada = data["EXPIRADA"] as! String
            let email = data["EMAIL"] as! String
            let fecha = data["FECHA_VISITA"] as! String
            let invitacion = Invitacion(folio: codigo, idUsuario: usuario, nombres: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, placas: placas, horaEntrada: horaEntrada, horaSalida: horaSalida, fechaValida: fecha, esExpirada: expirada == "1", email: email)
            visitantes.append(invitacion)
        }
        
        return visitantes
    }
}
