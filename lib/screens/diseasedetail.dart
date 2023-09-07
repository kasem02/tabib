import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DiseaseDetail extends StatefulWidget {
  final String disease;
  const DiseaseDetail({required this.disease});
  @override
  _DiseaseDetailState createState() => _DiseaseDetailState();
}

class _DiseaseDetailState extends State<DiseaseDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.disease,
          style: GoogleFonts.lato(color: Colors.black),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('serives')
              .orderBy('Name')
              .startAt([widget.disease]).endAt(
                  [widget.disease + '\uf8ff']).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
                physics: ClampingScrollPhysics(),
                children: snapshot.data!.docs.map((document) {
                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey[50],
                              ),
                              child: Text(
                                "اعلان",
                                style: GoogleFonts.lato(
                                    color: Colors.black54, fontSize: 18),
                              )),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 15, right: 15),
                              padding: EdgeInsets.only(left: 20, right: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey[50],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              )),

                        ],
                      ),
                    ),
                  );
                }).toList());
          }),
    );
  }
}
