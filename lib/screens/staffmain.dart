import 'dart:async';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

import 'advertisement.dart';
import 'doctorCancledappointment.dart';
import 'doctorapprovedApoinemt.dart';
import 'mydoctorappoinment.dart';
import 'staff_add.dart';
import 'stuff_edit.dart';
FirebaseAuth _auth = FirebaseAuth.instance;
late User user;
late String _documentID;
class staffmain extends StatefulWidget {
  const staffmain({Key? key}) : super(key: key);


  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }








  @override
  State<staffmain> createState() => _staffmainState();
}

class _staffmainState extends State<staffmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('serives').orderBy('Name').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return snapshot.data?.size == 0
                  ? Center(
                child: Text('لا توجد خدمات تم اضافتها ',
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
                itemCount: snapshot.data?.size,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = snapshot.data!.docs[index];

                  return Card(
                    elevation: 2,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => stuffeditscreen(
                              title: document['Name'],
                              discrtion: document['Description'],
                              Availability: document['Availability'],
                              price: document['Price'],
                              doc_id: document.id,
                            ),
                          ),
                        );
                      },
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                document['Name'],
                                style: GoogleFonts.lato(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0,
                            ),
                          ],
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 5),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20, right: 10, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        document['Availability'],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "   سعر الخدمه : " + document['Price'] + " د.ل ",
                                      style: GoogleFonts.lato(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  tooltip: 'حذف الخدمه',
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.black87,
                                  ),
                                  onPressed: () async {
                                    print("حدف الخدمه" + document.id);
                                    await FirebaseFirestore.instance
                                        .collection('serives')
                                        .doc(document.id)
                                        .delete();
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => stuff_addcreen(),
            ),
          );






        },

        child: Icon(Icons.add),
      ),
    );
  }
}
