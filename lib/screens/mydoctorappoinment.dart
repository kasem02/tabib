import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




class mydcotorappiment extends StatefulWidget {
  const mydcotorappiment({Key? key}) : super(key: key);

  @override
  State<mydcotorappiment> createState() => _mydcotorappimentState();
}

class _mydcotorappimentState extends State<mydcotorappiment> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> confirmAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc(docID).update({
      'approved': 'true',

    });

  }
  Future<void> refuseAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc(docID).update({
      'approved': 'false',

    });

  }

  String _dateFormatter(String _timestamp) {
    String formattedDate =
    DateFormat('dd-MM-yyyy').format(DateTime.parse(_timestamp));
    return formattedDate;
  }

  String _timeFormatter(String _timestamp) {
    String formattedTime =
    DateFormat('kk:mm').format(DateTime.parse(_timestamp));
    return formattedTime;
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("نعم"),
      onPressed: () {
        confirmAppointment(_documentID);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد الموعد"),
      content: Text("هل تريد تاكيد الموعد ؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showrefuseAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("لا"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("نعم"),
      onPressed: () {
        showrefuseAlertDialog(_documentID as BuildContext);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("رفض الموعد"),
      content: Text("هل تريد رفض الموعد ؟"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _checkDiff(DateTime _date) {
    var diff = DateTime.now().difference(_date).inHours;
    if (diff > 2) {
      return true;
    } else {
      return false;
    }
  }

  _compareDate(String _date) {
    if (_dateFormatter(DateTime.now().toString())
        .compareTo(_dateFormatter(_date)) ==
        0) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('appointments').orderBy('date').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('Stream snapshot: ${snapshot.data}'); // Add this line

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> filteredList = snapshot.data!.docs.where((document) {
            // Specify the condition based on the 'doctormail' field
            print("this is the doctor list" + document['doctormail']);
           return document['doctormail'] == user!.email! && document['approved'] =='onhold';


          }).toList();

          return filteredList.isEmpty
              ? Center(
            child: Text(
              'لا توجد مواعيد',
              style: GoogleFonts.lato(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
          )
              : ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              DocumentSnapshot document = filteredList[index];
              print(_compareDate(document['date'].toDate().toString()));
              if (_checkDiff(document['date'].toDate())) {
                confirmAppointment(document.id);
              }
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {},
                  child: ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            document['doctor'],
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          _compareDate(document['date'].toDate().toString())
                              ? "TODAY"
                              : "",
                          style: GoogleFonts.lato(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 0,
                        ),
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        _dateFormatter(
                            document['date'].toDate().toString()),
                        style: GoogleFonts.lato(),
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 20, right: 10, left: 16),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  document['approved'] == 'onhold'
                                      ? 'قيد الانتظار'
                                      : document['approved'] == 'true'
                                      ? 'تمت الموافقة'
                                      : 'تم رفض الموعد',
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "التوقيت: " +
                                      _timeFormatter(
                                        document['date']
                                            .toDate()
                                            .toString(),
                                      ),
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "اسم المريض: " + document['name'],
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              tooltip: 'قبول الموعد ',
                              icon: Icon(
                                Icons.add_box,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                print(">>>>>>>>>" + document.id);
                                _documentID = document.id;
                                showAlertDialog(context);
                              },
                            ),
                            IconButton(
                              tooltip: 'قبول الموعد ',
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                print(">>>>>>>>>" + document.id);
                                _documentID = document.id;
                                showrefuseAlertDialog(context);
                              },
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


