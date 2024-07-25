part of 'package:AlMokhtar_Clinic/app/myapp.dart';

extension _AuthListener on _MyAppState {
  _onAuthListener(BuildContext context, AuthState state) {
    if (state.loginStatus == AppStatus.Success) {
      _router.go(AppRoutes.patientHome.path);
    }
    if (state.loginStatus == AppStatus.Failure) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _router.routerDelegate.navigatorKey.currentContext?.showFailureAlert(
            message: "يرجى التأكد من كلمة المرور أو البريد الإلكتروني");
      });
    }
  }
}
