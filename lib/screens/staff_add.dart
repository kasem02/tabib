
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/screens/myAppointments.dart';
import 'package:intl/intl.dart';

class stuff_addcreen extends StatefulWidget {

  @override
  _stuff_addcreenState createState() => _stuff_addcreenState();
}
FirebaseAuth _auth = FirebaseAuth.instance;
late User? user;
Future<void> _getUser() async {
  user = _auth.currentUser!;
}


class _stuff_addcreenState extends State<stuff_addcreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController AvailabilityController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController textarea = TextEditingController();


  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }


  Future<void> _createAppointment() async {
    /*
   *  print(dateUTC + ' ' + date_Time + ':00');
    FirebaseFirestore.instance.collection('appointments').doc(user.email).collection('pending').doc().set({'name': _nameController.text, 'phone': _phoneController.text, 'description': _descriptionController.text, 'doctor': _doctorController.text, 'padding': "false",

      'date': DateTime.parse(dateUTC + ' ' + date_Time + ':00'),
    }, SetOptions(merge: true));
   *
   *
   *
   * */

    FirebaseFirestore.instance
        .collection('serives')
        .doc().set({
      'Name': _nameController.text,
      'Price': priceController.text,
      'Description': _descriptionController.text,
      'Availability': AvailabilityController.text,


    }, SetOptions(merge: true));
  }
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "حسنا!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "تم تسجيل الموعد",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
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


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // الوصول إلى العنصر الجديد هنا
  }
  @override
  void initState() {
    super.initState();
    _getUser();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'حجز موعد',
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
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (OverscrollIndicatorNotification overscroll) {
            overscroll.disallowIndicator();
            return true ;
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/appointment.jpg'),
                  height: 250,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'قم بادخال المعلومات التالية',
                          style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _nameController,
                        focusNode: f1,
                        textAlign: TextAlign.center,

                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'عنوان الخدمه  ',

                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,

                            fontWeight: FontWeight.w800,

                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          f1.unfocus();
                          FocusScope.of(context).requestFocus(f2);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),


                      Container(
                        height: 60, // Set the desired height
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          focusNode: f2,
                          textAlign: TextAlign.center,

                          controller: priceController,
                          style: GoogleFonts.lato(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            contentPadding:
                            EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(90.0)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[350],
                            hintText: 'سعر الخدمه*',
                            hintStyle: GoogleFonts.lato(
                              color: Colors.black26,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          onFieldSubmitted: (String value) {
                            f2.unfocus();
                            FocusScope.of(context).requestFocus(f3);
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        focusNode: f4,
                        controller: _descriptionController,
                        textAlign: TextAlign.center,
                        maxLines: 4,

                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'تفاصيل ان وجدت',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          f3.unfocus();
                          FocusScope.of(context).requestFocus(f4);
                        },
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        focusNode: f5,
                        controller: AvailabilityController,
                        //      initialValue: user!.displayName!,
                        textAlign: TextAlign.center,


                        style: GoogleFonts.lato(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          contentPadding:
                          EdgeInsets.only(left: 20, top: 10, bottom: 10),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(90.0)),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[350],
                          hintText: 'اسم الطبيب*',
                          hintStyle: GoogleFonts.lato(
                            color: Colors.black26,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,

                            primary: Colors.indigo,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(_nameController.text);
                              showAlertDialog(context);

                              _createAppointment();

                            }
                          },
                          child: Text(
                            "موافق",
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> update_data(String docID ) {
    return FirebaseFirestore.instance
        .collection('serives')
        .doc(docID).update({
      'Name': _nameController.text,
      'Price': priceController.text,
      'Description': _descriptionController.text,
      'Availability': AvailabilityController.text,
    });


  }



}
