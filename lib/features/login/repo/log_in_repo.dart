import 'package:firebase_auth/firebase_auth.dart';

class LogInRepo {
  static Future<UserCredential> firebaseSignIn(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  static Future<void> firebaseSignOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
