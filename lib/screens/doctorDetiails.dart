import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/updateDoctorDetiles.dart';
import 'package:health_and_doctor_appointment/updateUserDetails.dart';

class doctorDetiails extends StatefulWidget {
  const doctorDetiails({Key? key}) : super(key: key);

  @override
  State<doctorDetiails> createState() => _doctorDetiailsState();
}

class _doctorDetiailsState extends State<doctorDetiails> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  List labelName = [
    'Name1',
    'Email',
    'Mobile Number',
    'openHour',
    'closeHour',
  ];

  List value = [
    'name',
    'doctormail',
    'phone',
    'openHour',
    'closeHour',
  ];

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('doctors')
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          var userData = snapshot.data as DocumentSnapshot;
          return ListView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            children: List.generate(
              5, // Changed from 6 to 5
                  (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => updatedoctorDetils(
                          label: labelName[index],
                          field: value[index],
                        ),
                      ),
                    );
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      height: MediaQuery.of(context).size.height / 14,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            labelName[index],
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userData[value[index]]?.isEmpty ?? true
                                ? 'Not Added'
                                : userData[value[index]],
                            style: GoogleFonts.lato(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}