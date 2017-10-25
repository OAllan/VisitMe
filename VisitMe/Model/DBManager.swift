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
             "(ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), EMAIL VARCHAR(255))"
        
        let sqlCreaTablaUser = "CREATE TABLE IF NOT EXISTS USER" +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), EMAIL VARCHAR(255))"
        
        let sqlCreaTablaVigilante = "CREATE TABLE IF NOT EXISTS VIGILANTE" +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT, NOMBRE VARCHAR(255), APELLIDO_PATERNO VARCHAR(255), APELLIDO_MATERNO VARCHAR(255), EMAIL VARCHAR(255))"
        
        let sqlCreaTablaCondominio = "CREATE TABLE IF NOT EXISTS CONDOMINIO" +
        "(ID INTEGER PRIMARY KEY AUTOINCREMENT, ADMIN INTEGER, CALLE VARCHAR(255), NUMERO CHAR(5), COLONIA VARCHAR(255), CP CHAR(5), CIUDAD VARCHAR(255), ESTADO VARCHAR(100))"
        
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
}
