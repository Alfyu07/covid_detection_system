import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignUpProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool _hidePassword = true;
  String? _fullNameValue;
  String? _emailValue;
  String? _passwordValue;
  File? _image;

  GlobalKey<FormState> get formKey => _formKey;
  bool get isLoading => _isLoading;
  bool get hidePassword => _hidePassword;

  String? get fullNameValue => _fullNameValue;
  String? get emailValue => _emailValue;
  String? get passwordValue => _passwordValue;
  File? get image => _image;

  set isLoading(bool newValue) {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  set hidePassword(bool newValue) {
    _hidePassword = newValue;
    notifyListeners();
  }

  set fullNameValue(String? newValue) {
    _fullNameValue = newValue;
    notifyListeners();
  }

  set emailValue(String? newValue) {
    _emailValue = newValue;
    notifyListeners();
  }

  set passwordValue(String? newValue) {
    _passwordValue = newValue;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    _image = File(image.path);
    notifyListeners();
  }
}
