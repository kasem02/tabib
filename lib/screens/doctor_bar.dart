import 'dart:async';
import 'dart:ui';
import 'package:AlMokhtar_Clinic/firestore-data/searchList.dart';
import 'package:AlMokhtar_Clinic/screens/homePage.dart';
import 'package:AlMokhtar_Clinic/screens/myAppointments.dart';
import 'package:AlMokhtar_Clinic/screens/userProfile.dart';
import 'package:AlMokhtar_Clinic/screens/doctorsList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:quick_actions/quick_actions.dart';

import 'Doctormain.dart';
import 'Doctorsettings.dart';
import 'docotrProfPage.dart';
import 'mydoctorappoinment.dart';

class doctor_bar extends StatefulWidget {
  const doctor_bar({Key? key}) : super(key: key);

  @override
  State<doctor_bar> createState() => _doctor_barState();
}

class _doctor_barState extends State<doctor_bar> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  List<Widget> _pages = [
    Doctormain(),
    doctorProfilepage(),
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }





  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: _pages[_selectedIndex],
        bottomNavigationBar: Container(

          decoration: BoxDecoration(
            color: Colors.grey,

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                color: Colors.black,



                haptic: true,
                tabBorderRadius: 40,
                gap: 5,
                activeColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.blue.withOpacity(0.7),
                textStyle: GoogleFonts.lato(
                  color: Colors.black,
                ),
                tabs: [
                  GButton(
                    iconSize: _selectedIndex != 0 ? 28 : 25,
                    icon: _selectedIndex == 0
                        ? FlutterIcons.home_fou
                        : FlutterIcons.home_variant_outline_mco,
                    text: 'الرئسية',
                  ),
                  GButton(
                    icon: FlutterIcons.doctor_mco,
                    text: 'حسابي',
                  ),


                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );  }
}
