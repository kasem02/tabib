part of 'package:AlMokhtar_Clinic/app/myapp.dart';

extension _Route on _MyAppState {
  void _initRoutes() {
    _router = GoRouter(
      initialLocation: '/login',
      routes: <GoRoute>[
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginPage();
          },
        ),
        GoRoute(
          path: '/home',
          builder: (BuildContext context, GoRouterState state) {
            return HomePage();
          },
          redirect: (context, state) {
            if (context.read<AuthBloc>().state.userType == UserType.doctor) {
              return '/doctorHome';
            } else {
              return null ;
            }
          },
        ),
        GoRoute(
          path: '/doctorHome',
          builder: (context, state) => const DoctorBar(),
        )
      ],
    );
  }
}
