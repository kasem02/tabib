import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/features/login/data/auth_data_source.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthDataSource loginDataSource;

  AuthBloc({required this.loginDataSource})
      : super(AuthState(
            userName: "",
            password: "",
            loginStatus: AppStatus.pure,
            logoutStatus: AppStatus.pure,
            userType: UserType.pure));

  void onChangeUserName({required String value}) {
    emit(state.copyWith(userName: value));
  }

  void onChangePassword({required String value}) {
    emit(state.copyWith(password: value));
  }

  Future<void> onFetchUser() async {
    try {
      final result = await loginDataSource.onFetchUser();
      emit(state.copyWith(userType: UserType.values.byName(result)));
    } on Exception {
      emit(state.copyWith(
          userType: UserType.pure, loginStatus: AppStatus.Success));
    }
  }

  void onLogin() async {
    emit(state.copyWith(loginStatus: AppStatus.Loading)) ;
    try {
      await loginDataSource.login(
          userName: state.userName, password: state.password);
      await onFetchUser() ;
      emit(state.copyWith(loginStatus: AppStatus.Success));
    } on Exception {
      emit(state.copyWith(loginStatus: AppStatus.Failure));
    }
  }

  void onLogOut() async {
    emit(state.copyWith(logoutStatus: AppStatus.Loading)) ;
    try {
      await loginDataSource.logout();
      emit(state.copyWith(logoutStatus: AppStatus.Success));
    } on Exception {
      emit(state.copyWith(logoutStatus: AppStatus.Failure));
    }
  }
}
