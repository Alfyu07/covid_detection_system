import 'dart:convert';
import 'dart:io';

import 'package:covidia/models/models.dart';
import 'package:http/http.dart' as http;

class MyApi {
  static Future<ApiReturnValue<PredictResult>> predict(File imageFile,
      {http.MultipartRequest? request}) async {
    String url = 'https://covidia-flask.azurewebsites.net/predict';
    final uri = Uri.parse(url);
    request ??= http.MultipartRequest(
      "POST",
      uri,
    )..headers["Content-Type"] = "application/json";

    final multipartFile =
        await http.MultipartFile.fromPath('image', imageFile.path);
    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Add item failed, please try again");
    }

    String responseBody = await response.stream.bytesToString();

    final data = jsonDecode(responseBody) as Map<String, dynamic>;

    PredictResult result = PredictResult.fromJson(data);

    return ApiReturnValue(value: result, message: "success");
    // PredictResult value = PredictResult.fromJson(data);
  }
}
