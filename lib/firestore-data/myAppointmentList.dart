import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyAppointmentList extends StatefulWidget {
  @override
  _MyAppointmentListState createState() => _MyAppointmentListState();
}

class _MyAppointmentListState extends State<MyAppointmentList> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future<void> deleteAppointment(String docID) {
    return FirebaseFirestore.instance.collection('appointments').doc(docID).delete();
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
        deleteAppointment(_documentID);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد الموعد"),
      content: Text("هل انت متاكد من حدف هدا الموعد"),
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
            return document['pathionmail'] == user!.email!;


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
                              ? "اليوم"
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
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                        document['date'].toDate().toString(),
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
                              tooltip: 'حذف الموعد',
                              icon: Icon(
                                Icons.delete,
                                color: Colors.black87,
                              ),
                              onPressed: () {
                                print(">>>>>>>>>" + document.id);
                                _documentID = document.id;
                                showAlertDialog(context);
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
