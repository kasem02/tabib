import 'package:AlMokhtar_Clinic/features/login/data/model/user_model.dart';
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

  Future<void> registerUser({required UserModel user}) async {
    final result = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    await result.user!.updateDisplayName(user.name) ;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(result.user!.uid)
        .set(user.toJson());
  }
}
