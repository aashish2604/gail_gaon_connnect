import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in email
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  //register with email
  Future registerWithEmailAndPassword(
      String email, String password, String name, String phoneNumber) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = result.user!.uid;
      await FirebaseFirestore.instance
          .collection("user")
          .doc(uid)
          .set({"name": name, "contact_no": phoneNumber});
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'Password is weak');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: 'An account already exists for that email');
      }
    } catch (e) {
      print(e);
    }
  }

  //sign out
  Future signOut() async {
    await _auth.signOut();
  }
}
