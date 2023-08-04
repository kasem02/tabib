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
String userType = '' ;

Future<String> _getUser() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var user = await FirebaseFirestore.instance
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .get() ;
 var userType =  user.data()!['userType'].toString() ;
  debugPrint('this is the get user function $userType');

  return userType;
}
class _MyAppState extends State<MyApp> {
  FirebaseAuth _auth = FirebaseAuth.instance ;
  String user = '';

  @override
  void initState() {
    super.initState();
    _getUser().then((value) {
      setState(() {
        user = value;
        debugPrint("inti stat $user");

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: user == "doctor" ? '/doctor_home' : '/home',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => user == 'doctor' ? doctor_bar() : (user == 'pation' ? MainPage() : (user.isEmpty ? Skip() : MainPage())),
        '/home': (context) => user == 'doctor' ? doctor_bar() : MainPage(),
        '/profile': (context) => UserProfile(),
        '/MyAppointments': (context) => MyAppointments(),
        '/DoctorProfile': (context) => DoctorProfile(),
        '/Doctormain': (context) => DoctorProfile(),

        '/doctor_home': (context) => Doctormain(),
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      //home: FirebaseAuthDemo(),
    );
  }
}