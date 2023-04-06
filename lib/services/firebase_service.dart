import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> loginUser(String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return null;
    }on FirebaseAuthException catch (e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    }
    catch(e){
      return e.toString();
    }
  }
}