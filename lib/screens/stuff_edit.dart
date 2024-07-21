
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class stuffeditscreen extends StatefulWidget {
  final String title;
  final String discrtion;
  final String price;
  final String Availability;
  final String doc_id;




  const stuffeditscreen({Key? key, required this.title,required this.discrtion, required this.price, required this.Availability, required this.doc_id,}) : super(key: key);
  @override
  _stuffeditscreenState createState() => _stuffeditscreenState();
}
FirebaseAuth _auth = FirebaseAuth.instance;
late User? user;
Future<void> _getUser() async {
  user = _auth.currentUser!;
}


class _stuffeditscreenState extends State<stuffeditscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController AvailabilityController = TextEditingController();

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

  Future<void> refuseAppointment(String docID) {
    return FirebaseFirestore.instance
        .collection('appointments')
        .doc(docID).update({
      'approved': 'false',

    });

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
        "تم!",
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
    AvailabilityController.text = widget.Availability;
    _descriptionController.text = widget.discrtion;
    _nameController.text =   widget.title;
    priceController.text =   widget.price;

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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(_nameController.text);
                              print(widget.title);
                              showAlertDialog(context);

                              update_data(widget.doc_id);


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
