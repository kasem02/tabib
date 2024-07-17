import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:AlMokhtar_Clinic/firestore-data/notificationList.dart';
import 'package:AlMokhtar_Clinic/model/cardModel.dart';
import 'package:AlMokhtar_Clinic/carouselSlider.dart';
import 'package:AlMokhtar_Clinic/screens/exploreList.dart';
import 'package:AlMokhtar_Clinic/firestore-data/searchList.dart';
import 'package:AlMokhtar_Clinic/firestore-data/topRatedList.dart';
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
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
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