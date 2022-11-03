import 'package:covidia/models/models.dart';
import 'package:covidia/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

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

  Future<String?> changePassword(String currentPassword, String newPassword,
      String newPasswordConfirmation) async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user == null) return "You must login";

    final cred = EmailAuthProvider.credential(
      email: user.email ?? "",
      password: currentPassword,
    );

    try {
      await user.reauthenticateWithCredential(cred);
      await user.updatePassword(newPassword);
      return "success";
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
        case "wrong-password":
          return "your current password is invalid.";
        default:
          return "Change password failed. Please try again.";
      }
    }
  }

  Future<String?> signUp(
    String fullname,
    String email,
    String password,
    String imgUrl,
  ) async {
    try {
      final value = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = value.user;
      if (user == null) return "failed";

      await user.updateDisplayName(fullname).whenComplete(
            () => user.updatePhotoURL(imgUrl),
          );

      final userService = UserService();

      final UserModel userModel = UserModel(
        uid: user.uid,
        date: DateTime.now(),
        name: fullname,
        email: user.email,
        imgUrl: imgUrl,
        role: 1,
      );

      await userService.updateUserData(user: userModel);

      return "Successfully signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<User?> getLoggedUser() async {
    await _firebaseAuth.currentUser!.reload();
    return _firebaseAuth.currentUser;
  }

  Future<String?> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

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
