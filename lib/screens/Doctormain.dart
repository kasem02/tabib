import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:health_and_doctor_appointment/firestore-data/notificationList.dart';
import 'package:health_and_doctor_appointment/model/cardModel.dart';
import 'package:health_and_doctor_appointment/carouselSlider.dart';
import 'package:health_and_doctor_appointment/screens/exploreList.dart';
import 'package:health_and_doctor_appointment/firestore-data/searchList.dart';
import 'package:health_and_doctor_appointment/firestore-data/topRatedList.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

import 'doctorCancledappointment.dart';
import 'doctorapprovedApoinemt.dart';
import 'mydoctorappoinment.dart';

class Doctormain extends StatefulWidget {
  const Doctormain({Key? key}) : super(key: key);

  @override
  State<Doctormain> createState() => _DoctormainState();
}

class _DoctormainState extends State<Doctormain> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('لوحه تحكم الطبيب'),
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.pending), text: 'مواعيد في الانتظار'),
                Tab(icon: Icon(Icons.done), text: 'مواعيد المقبوله'),
                Tab(icon: Icon(Icons.done), text: 'المواعيد المرفوضة'),

              ]),
            ),
            body: const TabBarView(children: [mydcotorappiment(),doctoraprrvedappmoent(),doctorcansledappmoent()]),
          ),
        ));
  }
}