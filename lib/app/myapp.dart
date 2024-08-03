import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app/data/user_data_source.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_bloc.dart';
import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/extensions/context_extensions.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/pages/doctor_add_page.dart';
import 'package:AlMokhtar_Clinic/features/home/pages/mainPage.dart';
import 'package:AlMokhtar_Clinic/features/login/data/auth_data_source.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/Auth_bloc.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/auth_state.dart';
import 'package:AlMokhtar_Clinic/features/login/pages/login_page.dart';
import 'package:AlMokhtar_Clinic/features/login/pages/register_page.dart';
import 'package:AlMokhtar_Clinic/firestore-data/searchList.dart';
import 'package:AlMokhtar_Clinic/screens/doctor_bar.dart';
import 'package:AlMokhtar_Clinic/screens/explorelistbyperiod.dart';
import 'package:AlMokhtar_Clinic/screens/staaf_bar.dart';
import 'package:AlMokhtar_Clinic/screens/userSettings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part '../global/auth_listener.dart';

part '../services/router.dart';

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(loginDataSource: AuthDataSource()),
        ),
        BlocProvider(
          create: (context) => AppBloc(userDataSource: UserDataSource()),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        theme: ThemeData(brightness: Brightness.light),
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthBloc, AuthState>(
                listenWhen: (previous, current) =>
                    current.loginStatus != previous.loginStatus,
                listener: _onAuthListener,
              ),
              BlocListener<AuthBloc, AuthState>(
                  listenWhen: (previous, current) =>
                      current.logoutStatus != previous.logoutStatus,
                  listener: (context, state) {
                    if (state.logoutStatus.isSuccess) {
                      while (_router.canPop()) {
                        _router.pop();
                      }
                      _router.pushReplacement(AppRoutes.login.path);
                      context.showSuccessAlert(
                        message: "تم تسجيل خروجك"
                      ) ;
                    }
                  }),
            ],
            child: GestureDetector(
              child: child,
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
            ),
          );
        },
      ),
    );
  }
}
