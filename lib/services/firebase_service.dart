import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hungry_jack/models/user.dart';

class FirebaseService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("Users");
  final CollectionReference faqRef =
      FirebaseFirestore.instance.collection("Faqs");

  Future<String?> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  //create a new user account
  Future<String?> createAccount(UserProfile userProfile) async {
    try {
      final User? user =
          (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userProfile.email,
        password: userProfile.password,
      ))
              .user;
      if (user != null) {
        await userRef.doc(user.uid).set(userProfile.toMap());
        sendVerificationEmail();
        return null;
      } else {
        return 'error in sign up';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return e.toString();
    }
  }

  void sendVerificationEmail() {
    firebaseAuth.currentUser?.sendEmailVerification();
  }

  Future<bool> checkEmailVerified() async {
    await firebaseAuth.currentUser?.reload();
    bool isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    return isEmailVerified;
  }

  Future<UserProfile> getProfile() async {
    DocumentSnapshot user = await userRef.doc(getUserId()).get();
    UserProfile profile = UserProfile.fromDocument(user);
    return profile;
  }

  String getUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  //logout user
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<QuerySnapshot> getFAQList() async {
    return faqRef.get();
  }

  Future<void> resetPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
