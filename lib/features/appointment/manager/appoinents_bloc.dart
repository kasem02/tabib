import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/features/appointment/data/appointments_data_source.dart';
import 'package:AlMokhtar_Clinic/features/appointment/manager/appointments_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentsBloc extends Cubit<AppointmentsState> {
  final AppointmentsDataSource dataSource;

  AppointmentsBloc({required this.dataSource})
      : super(AppointmentsState(
            docId: "",
            approvedAppointments: [],
            refuseState: AppStatus.pure,
            acceptState: AppStatus.pure,
            fetchState: AppStatus.pure,
            pendingAppointments: [],
            declinedAppointments: []));

  void onFetchAppointments() async {
    emit(state.copyWith(fetchState: AppStatus.Loading));
    try {
      final result = await dataSource.fetchAppointments();
      emit(state.copyWith(
          fetchState: AppStatus.Success,
          approvedAppointments: result
              .where((document) => document['approved'] == 'true')
              .toList(),
          declinedAppointments: result
              .where((document) => document['approved'] == 'false')
              .toList() ,

      ));
    } on Exception {
      emit(state.copyWith(
        fetchState: AppStatus.Failure ,
      )) ;
    }
  }

  void onAccept({required String id}) async {
    emit(state.copyWith(acceptState: AppStatus.Loading)) ;
    try{
      await dataSource.acceptAppointment(id) ;
      emit(state.copyWith(acceptState: AppStatus.Success)) ;
    } on Exception {
      emit(state.copyWith(acceptState: AppStatus.Failure)) ;
    }
  }

  void onDecline({required String id}) async {
    emit(state.copyWith(refuseState: AppStatus.Loading)) ;
    try{
      await dataSource.declineAppointment(id) ;
      emit(state.copyWith(refuseState: AppStatus.Success)) ;
    } on Exception {
      emit(state.copyWith(refuseState: AppStatus.Failure)) ;
    }
  }




}
