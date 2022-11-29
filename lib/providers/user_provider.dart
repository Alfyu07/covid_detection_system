import 'package:covidia/models/models.dart';
import 'package:covidia/services/authentication_service.dart';
import 'package:flutter/material.dart';

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
}
