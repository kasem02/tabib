import 'dart:async';
import 'dart:ui';
import 'package:AlMokhtar_Clinic/model/gbutton_model.dart';
import 'package:AlMokhtar_Clinic/widgets/app_scaffold.dart';
import 'package:AlMokhtar_Clinic/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../features/appointment/pages/Doctormain.dart';
import 'docotrProfPage.dart';

class DoctorBar extends StatelessWidget {
  const DoctorBar();
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: DoctorMain(),
    );
  }
}
