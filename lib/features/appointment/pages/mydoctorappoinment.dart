import 'package:AlMokhtar_Clinic/features/appointment/manager/appoinents_bloc.dart';
import 'package:AlMokhtar_Clinic/features/appointment/manager/appointments_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MyDoctorAppointment extends StatefulWidget {
  const MyDoctorAppointment({Key? key}) : super(key: key);

  @override
  State<MyDoctorAppointment> createState() => _MyDoctorAppointmentState();
}

class _MyDoctorAppointmentState extends State<MyDoctorAppointment> {
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

  showAlertDialog(BuildContext context , String id ) {
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
        context.read<AppointmentsBloc>().onAccept(id: id );
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تاكيد الموعد"),
      content: Text("هل تريد تاكيد الموعد ؟"),
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

  showrefuseAlertDialog(BuildContext context , String id ) {
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
        context.read<AppointmentsBloc>().onDecline(id: id );
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("رفض الموعد"),
      content: Text("هل تريد رفض الموعد ؟"),
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

  _checkDiff(DateTime _date) {
    var diff = DateTime
        .now()
        .difference(_date)
        .inHours;
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentsBloc, AppointmentsState>(
      builder: (context, state) {
        return SafeArea(
            child: state.pendingAppointments.isEmpty
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
              itemCount: state.pendingAppointments.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = state.pendingAppointments[index];
                if (_checkDiff(document['date'].toDate())) {
                  context.read<AppointmentsBloc>().onAccept(id:document.id);
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              IconButton(
                                tooltip: 'قبول الموعد ',
                                icon: Icon(
                                  Icons.check,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  print(">>>>>>>>>" + document.id);
                                  showAlertDialog(context , document.id);
                                },
                              ),
                              IconButton(
                                tooltip: 'رفض الموعد ',
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.black87,
                                ),
                                onPressed: () {
                                  print(">>>>>>>>>" + document.id);
                                  showrefuseAlertDialog(context , document.id);
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
            ));
      },
    );
  }
}
