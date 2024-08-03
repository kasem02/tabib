part of 'package:AlMokhtar_Clinic/app/myapp.dart';

extension _Route on _MyAppState {
  void _initRoutes() {
    _router = GoRouter(
      initialLocation: AppRoutes.login.path,
      routes: <GoRoute>[
        GoRoute(
          path: AppRoutes.login.path,
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: AppRoutes.patientHome.path,
          onExit: (context, state) {
            _router.go(AppRoutes.login.path);
            return true;
          },
          builder: (BuildContext context, GoRouterState state) {
            return MainPage();
          },
          redirect: (context, state) {
            if (context.read<AuthBloc>().state.userType == UserType.doctor) {
              return AppRoutes.doctorHome.path;
            } else if (context.read<AuthBloc>().state.userType ==
                UserType.staff) {
              return AppRoutes.staffHome.path;
            } else {
              return null;
            }
          },
        ),
        GoRoute(
          onExit: (context, state) {
            _router.go(AppRoutes.login.path);
            return true;
          },
          path: AppRoutes.doctorHome.path,
          builder: (context, state) => const DoctorBar(),
        ),
        GoRoute(
          path: AppRoutes.searchList.path,
          builder: (context, state) => SearchList(
            searchKey: state.extra as String,
          ),
        ),
        GoRoute(
          path: AppRoutes.staffHome.path,
          builder: (context, state) => StaffBar(),
        ),
        GoRoute(
          path: AppRoutes.settings.path,
          builder: (context, state) => UserSettings(),
        ),
        GoRoute(
          path: AppRoutes.doctorAddPage.path,
          builder: (context, state) => DoctorAddPage(),
        ),
        GoRoute(
          path: AppRoutes.registerPage.path,
          builder: (context, state) => UserRegisterPage(),
        ),
        GoRoute(
          path: AppRoutes.periodDoctorsPage.path,
          builder: (context, state) {
            return ExploreListbyperoid(peroid: state.extra as String);
          },
        ),
      ],
    );
  }
}
