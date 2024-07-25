import 'package:AlMokhtar_Clinic/app_status.dart';

import '../data/doctor_model.dart';

class DoctorsRegisterState {
  final List<DoctorModel> doctors;

  final AppStatus fetchState;
  final AppStatus addState;
  final AppStatus deleteState;

  const DoctorsRegisterState(
      {required this.doctors,
      required this.fetchState,
      required this.addState,
      required this.deleteState});

  DoctorsRegisterState copyWith(
      {List<DoctorModel>? doctors,
      AppStatus? fetchState,
      AppStatus? deleteState,
      AppStatus? addState}) {
    return DoctorsRegisterState(
        addState: addState ?? this.addState,
        deleteState: deleteState ?? this.deleteState,
        fetchState: fetchState ?? this.fetchState,
        doctors: doctors ?? this.doctors);
  }
}
