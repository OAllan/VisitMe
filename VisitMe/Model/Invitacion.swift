import Foundation

class Invitacion{

    //Var instancia

    var folio: String?
    var idUsuario: String?
    var nombres: String?
    var apellidoPaterno: String?
    var apellidoMaterno: String?
    var placas: String?
    var horaEntrada: String?
    var horaSalida: String?
    var fechaValida: String?
    var esExpirada: Bool?
    var email: String?

    //Constructor

    init(folio: String, idUsuario: String, nombres: String, apellidoPaterno: String, apellidoMaterno: String,
    placas: String?, horaEntrada: String, horaSalida: String, fechaValida: String, esExpirada: Bool, email: String){
        self.folio = folio
        self.idUsuario = idUsuario
        self.nombres = nombres
        self.apellidoPaterno = apellidoPaterno
        self.apellidoMaterno = apellidoMaterno
        self.placas = placas
        self.horaEntrada = horaEntrada
        self.horaSalida = horaSalida
        self.fechaValida = fechaValida
        self.esExpirada = esExpirada
        self.email = email
    }

    //Getters

    func getFolio() -> String{
        return self.folio!
    }

    func getIdUsuario() -> String{
        return self.idUsuario!
    }

    func getNombres() -> String{
        return self.nombres!
    }

    func getApellidoPaterno() -> String{
        return self.apellidoPaterno!
    }

    func getApellidoMaterno() -> String{
        return self.apellidoMaterno!
    }

    func getPlacas() -> String{
        return self.placas!
    }

    func getHoraEntrada() -> String{
        return self.horaEntrada!
    }

    func getHoraSalida() -> String{
        return self.horaSalida!
    }

    func getFechaValida() -> String{
        return self.fechaValida!
    }

    func getEsExpirada() -> Bool{
        return self.esExpirada!
    }

    func getEmail() -> String{
        return self.email!
    }

    //Setters

    func setFolio(folio: String){
        self.folio = folio
    }

    func setIdUsuario(idUsuario: String){
        self.idUsuario = idUsuario
    }

    func setNombres(nombres: String){
        self.nombres = nombres
    }

    func setApellidoPaterno(apellidoPaterno: String){
        self.apellidoPaterno = apellidoPaterno
    }

    func setApellidoMaterno(apellidoMaterno: String){
        self.apellidoMaterno = apellidoMaterno
    }

    func setPlacas(placas: String){
        self.placas = placas
    }

    func setHoraEntrada(horaEntrada: String){
        self.horaEntrada = horaEntrada
    }

    func setHoraSalida(horaSalida: String){
        self.horaSalida = horaSalida
    }

    func setFechaValida(fechaValida: String){
        self.fechaValida = fechaValida
    }

    func setEsExpirada(esExpirada: Bool){
        self.esExpirada = esExpirada
    }

    func setEmail(email: String){
        self.email = email
    }
}
