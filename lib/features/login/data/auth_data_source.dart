import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSource {
  final _auth = FirebaseAuth.instance;

  Future<void> login(
      {required String userName, required String password}) async {
    await _auth.signInWithEmailAndPassword(
      email: userName,
      password: password,
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<String> onFetchUser() async {
    var user = await FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    var userType = user.data()!['userType'].toString();

    return userType;
  }
}
