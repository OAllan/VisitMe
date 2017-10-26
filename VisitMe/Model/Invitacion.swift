import Foundation

class Invitacion{

    //Var instancia

    var folio: String?
    var idUsuario: String?
    var nombres: String?
    var apellidoPaterno: String?
    var apellidoMaterno: String?
    var placas: String?
    var horaEntrada: Date?
    var horaSalida: Date?
    var fechaValida: Date?
    var esExpirada: Bool?
    var email: String?

    //Constructor

    init(folio: String, idUsuario: String, nombres: String, apellidoPaterno: String, apellidoMaterno: String,
    placas: String, horaEntrada: Date, horaSalida: Date, fechaValida: Date, esExpirada: Bool, email: String){
        self.folio = folio
        self. idUsuario = idUsuario
        self. nombres = nombres
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
        return self.apellidoPaterno
    }

    func getApellidoMaterno() -> String{
        return self.apellidoMaterno!
    }

    func getPlacas() -> String{
        return self.placas!
    }

    func getHoraEntrada() -> Date{
        return self.horaEntrada!
    }

    func getHoraSalida() -> Date{
        return self.horaSalida!
    }

    func getFechaValida() -> Date{
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

    func setHoraEntrada(horaEntrada: Date){
        self.horaEntrada = horaEntrada
    }

    func setHoraSalida(horaSalida: Date){
        self.horaSalida = horaSalida
    }

    func setFechaValida(fechaValida: Date){
        self.fechaValida = fechaValida
    }

    func setEsExpirada(esExpirada: Bool){
        self.esExpirada = esExpirada
    }

    func setEmail(email: String){
        self.email = email
    }
}