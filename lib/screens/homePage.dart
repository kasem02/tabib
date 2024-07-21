import 'dart:async';
import 'dart:ui';
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


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _doctorName = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  Future _signOut() async {
    await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _doctorName = new TextEditingController();
  }

  @override
  void dispose() {
    _doctorName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? _message;
    DateTime now = DateTime.now();
    String _currentHour = DateFormat('kk').format(now);
    int hour = int.parse(_currentHour);

    setState(
      () {
        if (hour >= 5 && hour < 12) {
          _message = 'صباح الخير';
        } else if (hour >= 12 && hour <= 17) {
          _message = 'مساء الخير';
        } else {
          _message = 'مساء الخير';
        }
      },
    );
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor, // Set background color to transparent
      key: _scaffoldKey,
      appBar: AppBar(
        // ... Your app bar code ...
      ),
      body: Container(
        decoration: BoxDecoration(
          // Set the background image here
        ),
        child: SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20, bottom: 10),
                      child: Center(
                        child: Text(
                          user.displayName! + " " + "مرحبا بك  " ,
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,

                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20, bottom: 25),
                      child: Center(
                        child: Text(
                          "لنجد لك طبيبك",
                          style: GoogleFonts.lato(

                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
                      child: TextFormField(
                        textInputAction: TextInputAction.search,
                        controller: _doctorName,
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          hintText: 'البحث عن طبيب',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                          suffixIcon: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue[900]!.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              iconSize: 20,
                              splashRadius: 20,
                              color: Colors.white,
                              icon: Icon(FlutterIcons.search1_ant),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        onFieldSubmitted: (String value) {
                          setState(
                                () {
                              value.length == 0
                                  ? Container()
                                  : Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchList(
                                    searchKey: value,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 23, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "صحتك تهمنا",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Carouselslider(),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Text(
                          "المتخصصين",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      height: 170,
                      padding: EdgeInsets.only(top: 14),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: cards.length,
                        itemBuilder: (context, index) {
                          //print("images path: ${cards[index].cardImage.toString()}");
                          return Container(
                            margin: EdgeInsets.only(right: 14),
                            height: 150,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(cards[index].cardBackground),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(3, 3),
                                  ),
                                ]
                              // image: DecorationImage(
                              //   image: AssetImage(cards[index].cardImage),
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                            // ignore: deprecated_member_use






                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExploreList(
                                        type: cards[index].doctor,
                                      )),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),



                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 29,
                                        child: Icon(
                                          cards[index].cardIcon,
                                          size: 26,
                                          color:
                                          Color(cards[index].cardBackground),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      cards[index].doctor,
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Text(
                          "الفترات",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),

                    Container(
                      height: 170,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 14),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        itemCount: proid.length,
                        itemBuilder: (context, index) {
                          //print("images path: ${cards[index].cardImage.toString()}");
                          return Container(
                            margin: EdgeInsets.only(right: 14),
                            height: 150,
                            width: 140,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(proid[index].cardBackground),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 4.0,
                                    spreadRadius: 0.0,
                                    offset: Offset(3, 3),
                                  ),
                                ]
                              // image: DecorationImage(
                              //   image: AssetImage(cards[index].cardImage),
                              //   fit: BoxFit.fill,
                              // ),
                            ),
                            // ignore: deprecated_member_use






                            child: ElevatedButton(
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => ExploreListbyperoid(
                                //         peroid: proid[index].doctor,
                                //       )),
                                // );
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),



                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 29,
                                        child: Icon(
                                          proid[index].cardIcon,
                                          size: 26,
                                          color:
                                          Color(proid[index].cardBackground),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      proid[index].doctor,
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      alignment: Alignment.centerLeft,
                      child: Center(
                        child: Text(
                          "افضل الاطباء",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.lato(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: TopRatedList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );  }
}
