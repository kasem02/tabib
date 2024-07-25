

import 'package:firebase_auth/firebase_auth.dart';

class UserDataSource {
  FirebaseAuth _auth = FirebaseAuth.instance ;

  Future<User?> onFetchUserData() async {
    return _auth.currentUser ;
  }


}