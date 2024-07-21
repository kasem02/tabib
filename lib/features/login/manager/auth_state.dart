import 'package:AlMokhtar_Clinic/app_status.dart';

class AuthState {
  final String userName;
  final String password;
  final AppStatus loginStatus;
  final AppStatus logoutStatus;
  final UserType userType;

  AuthState(
      {required this.userName,
      required this.password,
      required this.loginStatus,
      required this.logoutStatus,
      required this.userType});

  AuthState copyWith(
      {String? userName,
      String? password,
      AppStatus? loginStatus,
      AppStatus? logoutStatus,
      UserType? userType}) {
    return AuthState(
      logoutStatus: logoutStatus ?? this.logoutStatus,
      loginStatus: loginStatus ?? this.loginStatus,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        userType: userType ?? this.userType);
  }
}

enum UserType { doctor, patient, pure }
