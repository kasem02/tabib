import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentsState {
  final List<DocumentSnapshot> approvedAppointments;

  final List<DocumentSnapshot> declinedAppointments;

  final List<DocumentSnapshot> pendingAppointments;

  final AppStatus fetchState;

  final AppStatus refuseState;

  final AppStatus acceptState;

  final String docId;

  AppointmentsState(
      {required this.approvedAppointments,
      required this.declinedAppointments,
      required this.pendingAppointments,
      required this.fetchState,
      required this.refuseState,
      required this.acceptState,
      required this.docId});

  AppointmentsState copyWith({
    List<DocumentSnapshot>? approvedAppointments,
    List<DocumentSnapshot>? declinedAppointments,
    List<DocumentSnapshot>? pendingAppointments,
    AppStatus? fetchState,
    AppStatus? refuseState,
    AppStatus? acceptState,
    String? docId,
  }) {
    return AppointmentsState(
        docId: docId ?? this.docId,
        fetchState: fetchState ?? this.fetchState,
        acceptState: acceptState ?? this.acceptState,
        approvedAppointments: approvedAppointments ?? this.approvedAppointments,
        declinedAppointments: declinedAppointments ?? this.declinedAppointments,
        pendingAppointments: pendingAppointments ?? this.pendingAppointments,
        refuseState: refuseState ?? this.refuseState);
  }
}
