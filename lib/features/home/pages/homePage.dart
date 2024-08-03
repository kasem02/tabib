import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_bloc.dart';
import 'package:AlMokhtar_Clinic/model/cardModel.dart';
import 'package:AlMokhtar_Clinic/carouselSlider.dart';
import 'package:AlMokhtar_Clinic/screens/exploreList.dart';
import 'package:AlMokhtar_Clinic/firestore-data/topRatedList.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;
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

  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().onFetchUserData();
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
    String _currentHour = intl.DateFormat('kk').format(now);
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
      body: Container(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20, bottom: 10),
                        child: Center(
                          child: Text(
                            context.read<AppBloc>().state.userName + " " + "مرحبا بك  ",
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
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          textInputAction: TextInputAction.search,
                          controller: _doctorName,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
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
                            prefixIcon: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue[900]!.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: IconButton(
                                iconSize: 20,
                                splashRadius: 20,
                                color: Colors.white,
                                icon: Icon(FlutterIcons.search1_ant),
                                onPressed: () {
                                  context.push(AppRoutes.searchList.path, extra: _doctorName.text);
                                },
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
                                value.length == 0 ? Container() : context.push(AppRoutes.searchList.path, extra: value);
                              },
                            );
                          },
                        ),
                      ),
                      Text(
                        "صحتك تهمنا",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.lato(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Carouselslider(),
                      ),
                      Text(
                        "المتخصصين",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        height: 170,
                        child: ListView.builder(
                          reverse: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            //print("images path: ${cards[index].cardImage.toString()}");
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ExploreList(
                                            type: cards[index].doctor,
                                          )),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [Color(0xffA1D4ED), Color(0xff50BDF3)]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(3, 3),
                                      ),
                                    ]),
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
                                            color: Color(cards[index].cardBackground),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      cards[index].doctor,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
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
                      Text(
                        "الفترات",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(color: Colors.blue[800], fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        height: 170,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 14),
                        child: ListView.builder(
                          reverse: true,
                          physics: ClampingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          itemCount: period.length,
                          itemBuilder: (context, index) {
                            //print("images path: ${cards[index].cardImage.toString()}");
                            return InkWell(
                              onTap: () => context.push(AppRoutes.periodDoctorsPage.path, extra: period[index].doctor),
                              child: Container(
                                margin: EdgeInsets.only(right: 14),
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [Color(0xffA1D4ED), Color(0xff50BDF3)]),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(3, 3),
                                      ),
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 16,
                                    ),
                                    CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 29,
                                        child: Icon(
                                          period[index].cardIcon,
                                          size: 26,
                                          color: Color(period[index].cardBackground),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      period[index].doctor,
                                      style: GoogleFonts.lato(
                                          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
