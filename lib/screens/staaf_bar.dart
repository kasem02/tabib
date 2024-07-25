import 'dart:async';
import 'dart:ui';

import 'package:AlMokhtar_Clinic/features/doctors_register/pages/doctors_register_page.dart';
import 'package:AlMokhtar_Clinic/features/home/pages/doctorsList.dart';
import 'package:AlMokhtar_Clinic/model/gbutton_model.dart';
import 'package:AlMokhtar_Clinic/screens/staffprofile.dart';
import 'package:AlMokhtar_Clinic/widgets/app_scaffold.dart';
import 'package:AlMokhtar_Clinic/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:AlMokhtar_Clinic/screens/staffmain.dart';

class StaffBar extends StatelessWidget {
  StaffBar();

  final List<Widget> _pages = [
    staffmain(),
    DoctorsRegisterPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        navBarRelatedChild: _pages,
        navBar: AppNavBar(
          tabs: [
            GButtonModel(
              index: 0,
              selectedIcon: FlutterIcons.home_fou,
              nonSelectedIcon: FlutterIcons.home_variant_outline_mco,
              title: 'الخدمات',
            ),
            GButtonModel(
              index: 1,
              selectedIcon: FlutterIcons.doctor_mco,
              nonSelectedIcon: FlutterIcons.doctor_mco,
              title: 'الأطباء',
            ),
          ],
        ));
  }
}
