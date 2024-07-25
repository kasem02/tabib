

enum AppRoutes {
  patientHome ,
  login ,
  doctorHome, searchList, staffHome , settings, doctorAddPage, registerPage
}


extension Pather on AppRoutes {
  String get path => "/${this.name}" ;
}