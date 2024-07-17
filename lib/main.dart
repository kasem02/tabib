import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AlMokhtar_Clinic/screens/Doctormain.dart';
import 'package:AlMokhtar_Clinic/screens/doctorProfile.dart';
import 'package:AlMokhtar_Clinic/screens/firebaseAuth.dart';
import 'package:AlMokhtar_Clinic/mainPage.dart';
import 'package:AlMokhtar_Clinic/screens/myAppointments.dart';
import 'package:AlMokhtar_Clinic/screens/skip.dart';
import 'package:AlMokhtar_Clinic/screens/userProfile.dart';
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
  final user = await _getUser() ;
  runApp(MyApp(user: user,));
}

Future<String> _getUser() async {
  final _auth  = FirebaseAuth.instance ;
  var user = await FirebaseFirestore.instance
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .get();
  var userType = user.data()!['userType'].toString();
  debugPrint('this is the get user function $userType');

  return userType;
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  final String user;

  const MyApp({required this.user});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool loggedIn = false;

  @override
  void initState() {
    setState(() {
      loggedIn = widget.user == 'doctor' ||
          widget.user == 'patient' ||
          widget.user == 'staff'; // تمت إضافة الشرط لـ user == 'staff'
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: loggedIn
          ? (widget.user == 'doctor'
              ? '/doctor_home'
              : (widget.user == 'staff' ? '/staff_home' : '/home'))
          : '/',
      routes: {
        '/': (context) => loggedIn
            ? (widget.user == 'doctor'
                ? doctor_bar()
                : (widget.user == 'patient'
                    ? MainPage()
                    : (widget.user == 'staff' ? staff_bar() : MainPage()))) //
            : Skip(),
        '/home': (context) => loggedIn
            ? (widget.user == 'doctor'
                ? doctor_bar()
                : (widget.user == 'patient'
                    ? MainPage()
                    : (widget.user == 'staff' ? staff_bar() : MainPage()))) //
            : Skip(),
        '/profile': (context) => UserProfile(),
        '/MyAppointments': (context) => MyAppointments(),
        'patient_home': (context) => MainPage(),
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
