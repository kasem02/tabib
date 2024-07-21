import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppointmentsDataSource {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> acceptAppointment(String docID) async {
    await _fireStore.collection('appointments').doc(docID).update({
      'approved': 'true',
    });
  }

  Future<void> declineAppointment(String docID) async {
    await _fireStore.collection('appointments').doc(docID).update({
      'approved': 'false',
    });
  }

  Future<List<QueryDocumentSnapshot<Object?>>> fetchAppointments() async {
    final snapshots =
        await _fireStore.collection('appointments').orderBy('date').get();
    final result = snapshots.docs
        .where((element) => element['doctormail'] == _auth.currentUser!.email)
        .toList();

    return result ;
  }
}
