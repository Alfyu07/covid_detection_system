import 'package:covidia/services/authentication_service.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider extends ChangeNotifier {
  final AuthenticationService _authService;

  AuthProvider(this._authService);

  bool isLoading = false;

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
}
