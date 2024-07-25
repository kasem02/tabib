import 'dart:async';
import 'dart:ui';
import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_bloc.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_state.dart';
import 'package:AlMokhtar_Clinic/features/home/pages/doctorsList.dart';
import 'package:AlMokhtar_Clinic/features/home/pages/homePage.dart';
import 'package:AlMokhtar_Clinic/features/home/pages/myAppointments.dart';
import 'package:AlMokhtar_Clinic/features/home/pages/userProfile.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/Auth_bloc.dart';
import 'package:AlMokhtar_Clinic/model/gbutton_model.dart';
import 'package:AlMokhtar_Clinic/widgets/app_button.dart';
import 'package:AlMokhtar_Clinic/widgets/app_scaffold.dart';
import 'package:AlMokhtar_Clinic/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class MainPage extends StatelessWidget {
  List<Widget> _pages = [
    DoctorsList(),
    HomePage(),
    MyAppointments(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      navBar: AppNavBar(
        tabs: [
          GButtonModel(
            index: 1,
            selectedIcon: FlutterIcons.search1_ant,
            nonSelectedIcon: FlutterIcons.search1_ant,
            title: 'البحث',
          ),
          GButtonModel(
            index: 0,
            nonSelectedIcon: FlutterIcons.home_variant_outline_mco,
            selectedIcon: FlutterIcons.home_fou,
            title: 'الرئسية',
          ),
          GButtonModel(
            index: 2,
            selectedIcon: Typicons.calendar,
            nonSelectedIcon: Typicons.calendar_outline,
            title: 'الجداول',
          ),
        ],
      ),
      navBarRelatedChild: _pages,
    );
  }
}
