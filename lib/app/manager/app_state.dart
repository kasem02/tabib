import 'package:AlMokhtar_Clinic/app_status.dart';

class AppState {
  final String userName;

  final String email;

  final AppStatus fetchUserState;

  AppState(
      {required this.email,
      required this.userName,
      required this.fetchUserState});

  AppState copyWith(
          {String? email, String? userName, AppStatus? fetchUserState}) =>
      AppState(
          email: email ?? this.email,
          userName: userName ?? this.userName,
          fetchUserState: fetchUserState ?? this.fetchUserState);
}
