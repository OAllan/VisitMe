//
//  DBManager.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 25/10/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation

class DBManager{
    
    var baseDatos: OpaquePointer? = nil
    
    func abrirBaseDeDatos() -> Bool{
        if let path = self.obtenerPath("VisitMeData.txt"){
            if sqlite3_open(path.absoluteString, &baseDatos) == SQLITE_OK {
                print("Conexion exitosa")
                return true
            }
            sqlite3_close(baseDatos)
        }
        return false
    }
    
    func obtenerPath(_ salida: String) -> URL? {
        if let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return path.appendingPathComponent(salida)
        }
        return nil
    }
    
    func crearTablas() -> Bool{
        let sqlCreaTablaAdmin = "CREATE TABLE IF NOT EXISTS ADMIN" +
             "(ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), EMAIL VARCHAR(255), PASSWORD VARCHAR(255))"
        
        let sqlCreaTablaUser = "CREATE TABLE IF NOT EXISTS USER" +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), EMAIL VARCHAR(255), PASSWORD VARCHAR(255))"
        
        let sqlCreaTablaVigilante = "CREATE TABLE IF NOT EXISTS VIGILANTE" +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), EMAIL VARCHAR(255), PASSWORD VARCHAR(255))"
        
        let sqlCreaTablaCondominio = "CREATE TABLE IF NOT EXISTS CONDOMINIO" +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT, ADMIN INTEGER, CALLE VARCHAR(255), NUMERO CHAR(5), COLONIA VARCHAR(255), CP CHAR(5), CIUDAD VARCHAR(255), ESTADO VARCHAR(100), FOREIGN KEY(ADMIN) REFERENCES ADMIN(ID))"
        
        let sqlCreaTablaCondominioVigilante = "CREATE TABLE IF NOT EXISTS CONDOMINIO_VIGILANTE" +
        "(CONDOMINIO INTEGER, VIGILANTE INTEGER, PRIMARY KEY(CONDOMINIO, VIGILANTE), FOREIGN KEY(CONDOMINIO) REFERENCES CONDOMINIO(ID),FOREIGN KEY(VIGILANTE) REFERENCES VIGILANTE(ID))"
        
        let sqlCreaTablaCondominioUsuario = "CREATE TABLE IF NOT EXISTS CONDOMINIO_USUARIO" +
        "(CONDOMINIO INTEGER, USUARIO INTEGER, PRIMARY KEY(CONDOMINIO, USUARIO), FOREIGN KEY(CONDOMINIO) REFERENCES CONDOMINIO(ID),FOREIGN KEY(USUARIO) REFERENCES USER(ID))"
        
        let sqlCreaTablaInvitacion = "CREATE TABLE IF NOT EXISTS INVITACION" +
        "(CODIGO VARCHAR(30) PRIMARY KEY, USUARIO INTEGER, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), PLACAS VARCHAR(8), HORA_ENTRADA TIMESTAMP DEFAULT CURRENT_TIMESTAMP, HORA_SALIDA TIMESTAMP DEFAULT CURRENT_TIMESTAMP, EXPIRADA CHAR(1), EMAIL VARCHAR(255), FOREIGN KEY (USUARIO) REFERENCES USER(ID))"
        
        let sqlCreaTabla = "\(sqlCreaTablaAdmin);\(sqlCreaTablaUser);\(sqlCreaTablaVigilante);\(sqlCreaTablaCondominio);\(sqlCreaTablaCondominioVigilante);\(sqlCreaTablaCondominioUsuario);\(sqlCreaTablaInvitacion);"
        
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlCreaTabla, nil, nil, &error) == SQLITE_OK {
            return true
        } else {
            sqlite3_close(baseDatos)
            let msg = String.init(cString: error!)
            print("Error: \(msg)")
            return false
        }
    }
    
    func registrarVigilante(nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        let sqlInserta = "INSERT INTO VIGILANTE (NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, EMAIL, PASSWORD) "
            + "VALUES ('\(nombre)', '\(apellidoPaterno)', '\(apellidoMaterno)', '\(email)', '\(password)')"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) == SQLITE_OK {
            print("Datos registrados")
        }
        else{
            sqlite3_close(baseDatos)
            let msg = String.init(cString: error!)
            print("Error: \(msg)")
        }
        
    }
    
    func registrarResidente(nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        let sqlInserta = "INSERT INTO USER (NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, EMAIL, PASSWORD) "
            + "VALUES ('\(nombre)', '\(apellidoPaterno)', '\(apellidoMaterno)', '\(email)', '\(password)')"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) == SQLITE_OK {
            print("Datos registrados")
        }
        else{
            sqlite3_close(baseDatos)
            let msg = String.init(cString: error!)
            print("Error: \(msg)")
        }
        
    }
    
    func registrarAdmin(nombre: String, apellidoPaterno: String, apellidoMaterno: String, password: String, email: String){
        let sqlInserta = "INSERT INTO ADMIN (NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO, EMAIL, PASSWORD) "
            + "VALUES ('\(nombre)', '\(apellidoPaterno)', '\(apellidoMaterno)', '\(email)', '\(password)')"
        var error: UnsafeMutablePointer<Int8>? = nil
        if sqlite3_exec(baseDatos, sqlInserta, nil, nil, &error) == SQLITE_OK {
            print("Datos registrados")
        }
        else{
            sqlite3_close(baseDatos)
            let msg = String.init(cString: error!)
            print("Error: \(msg)")
        }
        
    }
    
    func cargarVigilante(email: String) -> Vigilante? {
        let sqlConsulta = "SELECT ID, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO FROM VIGILANTE WHERE EMAIL = '\(email)'"
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            while sqlite3_step(declaracion) == SQLITE_ROW {
                let id = String.init(cString: sqlite3_column_text(declaracion, 0))
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 1))
                let apellidoPaterno = String.init(cString: sqlite3_column_text(declaracion, 2))
                let apellidoMaterno = String.init(cString: sqlite3_column_text(declaracion, 3))
                return Vigilante(id: id, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, email: email)
            }
        }
        return nil
    }
    
    func cargarResidente(email: String) -> Usuario? {
        let sqlConsulta = "SELECT ID, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO FROM USER WHERE EMAIL = '\(email)'"
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            while sqlite3_step(declaracion) == SQLITE_ROW {
                let id = String.init(cString: sqlite3_column_text(declaracion, 0))
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 1))
                let apellidoPaterno = String.init(cString: sqlite3_column_text(declaracion, 2))
                let apellidoMaterno = String.init(cString: sqlite3_column_text(declaracion, 3))
                return Usuario(id: id, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, email: email)
            }
        }
        return nil
    }
    
    func cargarAdmin(email: String) -> Admin? {
        let sqlConsulta = "SELECT ID, NOMBRE, APELLIDO_PATERNO, APELLIDO_MATERNO FROM ADMIN WHERE EMAIL = '\(email)'"
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            while sqlite3_step(declaracion) == SQLITE_ROW {
                let id = String.init(cString: sqlite3_column_text(declaracion, 0))
                let nombre = String.init(cString: sqlite3_column_text(declaracion, 1))
                let apellidoPaterno = String.init(cString: sqlite3_column_text(declaracion, 2))
                let apellidoMaterno = String.init(cString: sqlite3_column_text(declaracion, 3))
                return Admin(id: id, nombre: nombre, apellidoPaterno: apellidoPaterno, apellidoMaterno: apellidoMaterno, email: email)
            }
        }
        return nil
    }
    
    func compararPassword(email: String, password: String, tabla: String)->Bool{
        let sqlConsulta = "SELECT PASSWORD FROM \(tabla) WHERE EMAIL = '\(email)'"
        var declaracion: OpaquePointer? = nil
        if sqlite3_prepare_v2(baseDatos, sqlConsulta, -1, &declaracion, nil) == SQLITE_OK {
            while sqlite3_step(declaracion) == SQLITE_ROW {
                let pass = String.init(cString: sqlite3_column_text(declaracion, 0))
                print(pass)
                if pass == password{
                    return true;
                }
            }
        }
        return false;
    }
}
