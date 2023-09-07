import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_and_doctor_appointment/screens/Doctormain.dart';
import 'package:health_and_doctor_appointment/screens/doctorProfile.dart';
import 'package:health_and_doctor_appointment/screens/firebaseAuth.dart';
import 'package:health_and_doctor_appointment/mainPage.dart';
import 'package:health_and_doctor_appointment/screens/myAppointments.dart';
import 'package:health_and_doctor_appointment/screens/skip.dart';
import 'package:health_and_doctor_appointment/screens/userProfile.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/doctor_bar.dart';
import 'screens/staaf_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String? user = '';
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    _getUser().then((value) {
      setState(() {
        user = value;
        loggedIn = user == 'doctor' || user == 'patient';
      });
    });
  }

  Future<String> _getUser() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    var userType = user.data()!['userType'].toString();
    debugPrint('this is the get user function $userType');

    return userType;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: loggedIn ? (user == 'doctor' ? '/doctor_home' : (user == 'staff' ? '/staff_home' : '/home')) : '/',
      routes: {
        '/': (context) => loggedIn ? (user == 'doctor' ? doctor_bar() : (user == 'staff' ? staff_bar() : MainPage())) : Skip(),
        '/home': (context) => loggedIn ? (user == 'doctor' ? doctor_bar() : (user == 'patient' ? FireBaseAuth() : (user == 'staff' ? staff_bar() : staff_bar()))) : Skip(),
        '/profile': (context) => UserProfile(),
        '/MyAppointments': (context) => MyAppointments(),
        '/login': (context) => FireBaseAuth(),
        '/DoctorProfile': (context) => DoctorProfile(),
        '/Doctormain': (context) => DoctorProfile(),
        '/doctor_home': (context) => Doctormain(),
        '/staff_home': (context) => staff_bar(),
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
    );
  }
}