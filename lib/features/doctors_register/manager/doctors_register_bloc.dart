import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/data/doctor_model.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/data/doctors_register_local_data_source.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/manager/doctors_register_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsRegisterBloc extends Cubit<DoctorsRegisterState> {
  final DoctorsRegisterDataSource localDataSource;

  DoctorsRegisterBloc({required this.localDataSource})
      : super(DoctorsRegisterState(
            doctors: [],
            fetchState: AppStatus.pure,
            addState: AppStatus.pure,
            deleteState: AppStatus.pure));

  void onFetchDoctors() async {
    emit(state.copyWith(fetchState: AppStatus.Loading));
    try {
      final result = await localDataSource.fetchDoctors();
      emit(state.copyWith(fetchState: AppStatus.Success, doctors: result));
    } on Exception {
      emit(state.copyWith(fetchState: AppStatus.Failure));
    }
  }

  void onAddDoctor({required DoctorModel doctor}) async {
    emit(state.copyWith(addState: AppStatus.Loading));

    try {
      await localDataSource.addDoctor(doctor: doctor);
      emit(state.copyWith(
        addState: AppStatus.Success,
      ));
    } on Exception {
      emit(state.copyWith(addState: AppStatus.Failure));
    }
  }

  void onDeleteDoctor({required String email}) async {
    emit(state.copyWith(deleteState: AppStatus.Loading));

    try {
      await localDataSource.deleteDoctor(email: email);
      emit(state.copyWith(
        deleteState: AppStatus.Success,
      ));
    } on Exception {
      emit(state.copyWith(deleteState: AppStatus.Failure));
    }
  }
}
