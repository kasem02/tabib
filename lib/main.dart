import 'package:AlMokhtar_Clinic/app/myapp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

// Future<String> _getUser() async {
//   final _auth  = FirebaseAuth.instance ;
//   var user = await FirebaseFirestore.instance
//       .collection('users')
//       .doc(_auth.currentUser!.uid)
//       .get();
//   var userType = user.data()!['userType'].toString();
//   debugPrint('this is the get user function $userType');
//
//   return userType;
// }

