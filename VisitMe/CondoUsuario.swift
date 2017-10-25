import Foundation

class CondoUsuario{

    //Var instancia

    var idUsuario: String?
    var idCondominio: String?

    //Constructor

    init(idUsuario: String, idCondominio: String){
        self.idUsuario = idUsuario
        self.idCondominio = idCondominio
    }

    //Getters

    func getIdUsuario() -> String{
        return self.idUsuario!
    }

    func getIdCondominio() -> String{
        return self.idCondominio!
    }

    //Setters

    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }

    func setIdCondominio(idCondominio: String){
        self.idCondominio = idCondominio
    }
}