import 'package:covidia/models/models.dart';
import 'package:covidia/services/engine_service.dart';
import 'package:flutter/cupertino.dart';

class EngineProvider extends ChangeNotifier {
  final EngineService _service;
  EngineProvider(this._service);

  bool isLoading = false;

  List<EngineModel> models = [];
  EngineModel? selectedModel;

  Future<void> getModels() async {
    isLoading = true;
    notifyListeners();
    final result = await _service.getModels();

    if (result.value != null) {
      models = result.value!;
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getSelectedModel() async {
    isLoading = true;
    notifyListeners();
    final result = await _service.getModel();
    if (result.value != null) {
      selectedModel = result.value;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> setModel(EngineModel model) async {
    isLoading = true;
    notifyListeners();
    final result = await _service.setModel(model: model);
    if (result.value != null) {
      selectedModel = model;
    }
    isLoading = false;
    notifyListeners();
  }
}
