import 'package:flutter/widgets.dart';

class PreviewProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }
}
