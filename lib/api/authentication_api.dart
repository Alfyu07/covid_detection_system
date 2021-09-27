import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationApi {
  final FirebaseAuth _firebaseAuth;
  AuthenticationApi(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.idTokenChanges();

  Future<String?> sendResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "sent";
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return "Email address is invalid";
        case "user-not-found":
          return "No user found with this email.";
        case "too-many-requests":
          return "Too many requests to log into this account.";
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "user-disabled":
          return "User disabled.";
        default:
          return "Email not sent. Please try again.";
      }
    }
  }

  Future<String?> signUp(
      String fullname, String email, String password, String imgUrl) async {
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user != null) {
          value.user!.updateDisplayName(fullname);
          value.user!.updatePhotoURL(imgUrl);
        }
      });
      return "Successfully Signed up";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return "Email address is invalid";
        case "user-not-found":
          return "No user found with this email.";
        case "too-many-requests":
          return "Too many requests to log into this account.";
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "user-disabled":
          return "User disabled.";
        default:
          return "Registration Failed. Please try again.";
      }
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());

      return "signed in";
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "No user found with this email.";
        case "invalid-email":
          return "Email address is invalid";
        case "wrong-password":
          return "Wrong email/password combination.";
        case "too-many-requests":
          return "Too many requests to log into this account.";
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "user-disabled":
          return "User disabled.";
        default:
          return "Login failed. Please try again.";
      }
    }
  }

  Future<String?> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return "User logged out";
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "user-not-found":
          return "No user found with this email.";
        case "too-many-requests":
          return "Too many requests to log into this account.";
        case "operation-not-allowed":
          return "Server error, please try again later.";
        case "user-disabled":
          return "User disabled.";
        default:
          return "Log out. Please try again.";
      }
    }
  }
}
