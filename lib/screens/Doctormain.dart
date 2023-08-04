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

class Doctormain extends StatefulWidget {
  const Doctormain({Key? key}) : super(key: key);

  @override
  State<Doctormain> createState() => _DoctormainState();
}

class _DoctormainState extends State<Doctormain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Main'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData) {
            return Text("No data available");
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              return Card(
                child: ListTile(
                  title: Text(document['name']),
                  subtitle: Text(document['email']),
                  onTap: () {


                    // Do something when the tile is tapped
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
