import 'package:covidia/models/models.dart';
import 'package:covidia/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class UserProvider extends ChangeNotifier {
  final AuthenticationService _authService;
  UserProvider(this._authService);
  bool isLoading = false;
  UserModel? currentUser;

  Future<String?> signUp({
    required String fullname,
    required String email,
    required String password,
    required String imgUrl,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await _authService.signUp(
      fullname: fullname,
      email: email,
      password: password,
      imgUrl: imgUrl,
    );
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();
    final result = await _authService.signIn(email, password);
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<String?> signOut() async {
    final result = await _authService.signOut();
    if (result == "User logged out") {
      currentUser = null;
    }
    return result;
  }

  Future<void> getCurrentUser() async {
    isLoading = true;
    notifyListeners();

    final firebaseUser = await _authService.getCurrentUser();
    if (firebaseUser != null) {
      final result = await _authService.getUserData(firebaseUser.uid);
      currentUser = result.value;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<String> editProfile({
    required String newName,
    required String newEmail,
    required String password,
  }) async {
    isLoading = true;
    notifyListeners();

    if (currentUser == null) {
      return "You must login";
    }

    if (newEmail != currentUser!.email) {
      final changeEmailResult =
          await _authService.changeEmailAddress(password, newEmail);
      if (changeEmailResult != "success") return changeEmailResult!;
    }
    final UserModel newUserModel =
        currentUser!.copyWith(email: newEmail, name: newName);
    final editResult = await _authService.editProfile(
      userModel: newUserModel,
    );
    currentUser = newUserModel;
    isLoading = false;
    notifyListeners();
    return editResult;
  }
}
