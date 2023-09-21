





import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_and_doctor_appointment/firestore-data/userDetails.dart';

import 'doctorDetiails.dart';
class doctorsettingsupdate extends StatefulWidget {
  final String description;
  final String name;
  final String phone;

  const doctorsettingsupdate({Key? key, required this.description, required this.name, required this.phone}) : super(key: key);


  @override
  State<doctorsettingsupdate> createState() => _doctorsettingsupdateState();
}

class _doctorsettingsupdateState extends State<doctorsettingsupdate> {
  List<String> typeOptions = [
    'طبيب عام',
    'طبيب أسنان',
    'طبيب جراح',
    'أخصائي نساء وتوليد',
    'أخصائي أمراض قلب',
    'أخصائي أمراض جلدية',
    'طبيب قلب',
    'طبيب اذن وانف وحنجرة',
    'طبيب عيون',
    'طبيب اسنان',
    'طبيب جلدية',
    'طبيب غدد صماء',
    'طبيب امراض المخ والأعصاب',
    'طبيب امراض باطنة',
    'طبيب امراض صدرية',
    'طبيب المخ والأعصاب',
    'طبيب جراحة اليد والأطراف',
    'طبيب امراض الدم والأورام',
    'طبيب تغذية صحية',
    'طبيب نساء وولادة',
    'طبيب باطنة',
    'طبيب اطفال',
  ];
  List<String> periodOptions = ['فترة صباحية', 'فترة مسائية'];

  // Variables to hold selected values
  late String? selectedType = "طبيب عام" ;
  late String? selectedPeriod = "فترة صباحية";

  doctorDetiails detail = new doctorDetiails();
  TextEditingController nameController = TextEditingController();
  TextEditingController doctormailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();


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
    nameController.text = widget.name;
    _descriptionController.text = widget.description;
    phoneController.text = widget.phone;
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.indigo,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'تعديل معلومات',
          style: GoogleFonts.lato(
              color: Colors.indigo, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Form(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.only(top: 0),
            child: Column(

              children: [
                TextFormField(
                  controller: nameController,
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
                    hintText: 'اسم الطبيب',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                ),

                // Text input for 'doctormail'

                // Text input for 'phone'
                TextFormField(
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
                    hintText: 'رقم الهاتف',
                    hintStyle: GoogleFonts.lato(
                      color: Colors.black26,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  controller: phoneController,

                ),
                TextFormField(
                  controller: _descriptionController,
                  textAlign: TextAlign.center,

                  keyboardType: TextInputType.multiline,
                  maxLines: null,
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
                  textInputAction: TextInputAction.next,
                ),


                // Text input for 'type'
            DropdownButton<String>(
              value: selectedType,
              onChanged: (String? newValue) {
                setState(() {
                  selectedType = newValue!;
                });
              },
              items: typeOptions.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 18),
                  ),
                );
              }).toList(),
            ),
                // Text input for 'Period'
                DropdownButton<String>(
                  value: selectedPeriod,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedPeriod = newValue!;
                    });
                  },
                  items: periodOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }).toList(),
                ),                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey[50],
                  ),

                  child: TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('doctors')
                          .doc(user.uid).update({
                        'name': nameController.text,
                        'description' : _descriptionController.text,
                        'phone': phoneController.text,
                        'type': selectedType,
                        'Period': selectedPeriod,
                      }).then((value) {
                      }).catchError((error) {

        print(error.toString());

                      });
                    },
                    style: TextButton.styleFrom(primary: Colors.grey),
                    child: Text(
                      ' تعديل المعلومات',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  height: MediaQuery.of(context).size.height / 14,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueGrey[50],
                  ),

                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                      _signOut();
                    },
                    style: TextButton.styleFrom(primary: Colors.grey),
                    child: Text(
                      'تسجيل الخروج',
                      style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
