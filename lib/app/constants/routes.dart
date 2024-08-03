enum AppRoutes {
  patientHome,
  login,
  doctorHome,
  searchList,
  staffHome,
  settings,
  doctorAddPage,
  registerPage,
  periodDoctorsPage
}

extension Pather on AppRoutes {
  String get path => "/${this.name}";
}
