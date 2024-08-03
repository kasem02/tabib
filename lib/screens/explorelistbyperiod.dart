import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:AlMokhtar_Clinic/screens/doctorProfile.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class ExploreListbyperoid extends StatefulWidget {
  final String peroid;
  const ExploreListbyperoid({Key? key, required this.peroid}) : super(key: key);

  @override
  _ExploreListbyperoidState createState() => _ExploreListbyperoidState();
}

class _ExploreListbyperoidState extends State<ExploreListbyperoid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.peroid,
          style: GoogleFonts.lato(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: StreamBuilder(
           /* stream: FirebaseFirestore.instance.collection('doctors').orderBy('Period').startAt([widget.peroid]).endAt([widget.peroid]).snapshots(),

*/
            stream: FirebaseFirestore.instance.collection('doctors')
                .orderBy('Period')
                    .startAt([widget.peroid])
                    .endAt([widget.peroid + 'zzz'])
                .snapshots(),

        builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.size,
              itemBuilder: (context, index) {
                DocumentSnapshot doctor = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Card(
                    color: Colors.blue[50],
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 9,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorProfile(
                                doctor: doctor['name'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 25,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  doctor['name'],
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  doctor['type'],
                                  style: GoogleFonts.lato(
                                      fontSize: 16, color: Colors.black54),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Typicons.star_full_outline,
                                      size: 20,
                                      color: Colors.indigo[400],
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
