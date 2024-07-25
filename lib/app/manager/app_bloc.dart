import 'package:AlMokhtar_Clinic/app/data/user_data_source.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_state.dart';
import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Cubit<AppState> {
  final UserDataSource userDataSource;

  AppBloc({required this.userDataSource})
      : super(AppState(
            email: "", userName: "", fetchUserState: AppStatus.pure)) {}

  void onFetchUserData() async {
    try {
      final result = await userDataSource.onFetchUserData();
      emit(state.copyWith(
          userName: result!.displayName,
          email: result.email,
          fetchUserState: AppStatus.Success));
    } catch (e) {
      emit(state.copyWith(fetchUserState: AppStatus.Failure));
    }
  }
}
