import 'dart:convert';

import 'package:covidia/models/models.dart';
import 'package:http/http.dart' as http;

class EngineService {
  final String baseUrl = "https://covidia-flask-be.azurewebsites.net/";

  Future<ApiReturnValue<EngineModel>> getModel({http.Client? client}) async {
    client ??= http.Client();

    final String url = '${baseUrl}get-model';
    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode != 200) {
      return const ApiReturnValue(message: 'Please try again');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final engineData = data["data"] as Map<String, dynamic>;
    final EngineModel result = EngineModel.fromJson(engineData);
    return ApiReturnValue<EngineModel>(value: result);
  }

  Future<ApiReturnValue<List<EngineModel>>> getModels(
      {http.Client? client}) async {
    client ??= http.Client();

    final String url = '${baseUrl}get-models';
    final uri = Uri.parse(url);

    final response = await client.get(uri);

    if (response.statusCode != 200) {
      return const ApiReturnValue(message: 'Please try again');
    }
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final result = (data["data"] as List<dynamic>)
        .map((e) => EngineModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return ApiReturnValue(value: result);
  }

  Future<ApiReturnValue<String>> setModel({
    required EngineModel model,
    http.Client? client,
  }) async {
    client ??= http.Client();

    final url =
        "https://covidia-flask-be.azurewebsites.net/set-model?index=${model.index}";

    final uri = Uri.parse(url);
    final response = await client.get(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      return const ApiReturnValue(message: 'Please try again');
    }

    return const ApiReturnValue<String>(value: "Success");
  }
}
