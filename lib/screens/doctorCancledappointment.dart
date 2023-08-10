import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';




class doctorcansledappmoent extends StatefulWidget {
  const doctorcansledappmoent({Key? key}) : super(key: key);

  @override
  State<doctorcansledappmoent> createState() => _doctorcansledappmoentState();
}

class _doctorcansledappmoentState extends State<doctorcansledappmoent> {


  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late String _documentID;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
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
            return document['doctormail'] == user!.email! && document['approved'] =='false';


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
                // confirmAppointment(document.id);
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


