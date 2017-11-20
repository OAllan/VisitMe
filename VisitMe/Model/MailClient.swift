//
//  MailClient.swift
//  VisitMe
//
//  Created by Oscar Allan Ruiz Toledo  on 19/11/17.
//  Copyright © 2017 Oscar Allan Ruiz Toledo . All rights reserved.
//

import Foundation


class MailClient {
    
    func enviarMail(mail: String, mensaje: String, asunto: String, nombre: String){
        
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.gmail.com"
        smtpSession.username = "visitme.app.ios@gmail.com"
        smtpSession.password = "S3cr3t0123"
        smtpSession.port = 587
        smtpSession.authType = MCOAuthType.saslPlain
        smtpSession.connectionType = MCOConnectionType.startTLS
        smtpSession.connectionLogger = {(connectionID, type, data) in
            if data != nil {
                if let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue){
                    NSLog("Connectionlogger: \(string)")
                }
            }
        }
        
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: nombre, mailbox: mail)]
        builder.header.from = MCOAddress(displayName: "VisitMe Staff", mailbox: "visitme.app.ios@gmail.com")
        builder.header.subject = asunto
        builder.htmlBody = mensaje
        
        let rfc822Data = builder.data()
        let sendOperation = smtpSession.sendOperation(with: rfc822Data)
        sendOperation?.start { (error) -> Void in
            if (error != nil) {
                NSLog("Error sending email: \(error)")
            } else {
                NSLog("Successfully sent email!")
            }
        }
    }
}
