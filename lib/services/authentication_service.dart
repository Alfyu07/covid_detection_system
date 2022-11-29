import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore firestore;

  AuthenticationService(this._firebaseAuth, this.firestore);

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

  Future<String?> changePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
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

  Future<String?> signUp({
    required String fullname,
    required String email,
    required String password,
    String? imgUrl,
  }) async {
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

      final UserModel userModel = UserModel(
        uid: user.uid,
        date: DateTime.now(),
        name: fullname,
        email: user.email,
        imgUrl: imgUrl,
        role: 1,
      );

      await updateUserData(user: userModel);

      return "Successfully signed up";
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
        case "wrong-password":
          return "your current password is invalid.";
        default:
          return e.code;
      }
    }
  }

  Future<ApiReturnValue<UserModel>> getUserData(String uid) async {
    try {
      final doc = await firestore.collection('users').doc(uid).get();
      final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      final UserModel user = UserModel.fromJson(data);
      return ApiReturnValue(value: user);
    } catch (e) {
      return const ApiReturnValue(message: "there's something wrong");
    }
  }

  Future updateUserData({
    required UserModel user,
  }) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    return userCollection.doc(user.uid).set(user.toJson());
  }

  Future<User?> getCurrentUser() async {
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
