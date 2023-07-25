
import 'package:cafe_admin/db/dbhelper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final User? user = _auth.currentUser;

  static Future<bool> login (String email,String password) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return DbHelper.isAdmin(credential.user!.uid);
  }
  static Future<void> logOut() => _auth.signOut();
}