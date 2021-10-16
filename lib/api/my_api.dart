import 'dart:convert';
import 'dart:io';

import 'package:covidia/models/models.dart';
import 'package:http/http.dart' as http;

// ignore: avoid_classes_with_only_static_members
class MyApi {
  static Future<ApiReturnValue<PredictResult>> classifyImage(File imageFile,
      {http.MultipartRequest? request}) async {
    const String url = 'https://covidia-be.azurewebsites.net/predict';
    final uri = Uri.parse(url);
    request ??= http.MultipartRequest(
      "POST",
      uri,
    )..headers["Content-Type"] = "application/json";

    final multipartFile =
        await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Add item failed, please try again");
    }

    final String responseBody = await response.stream.bytesToString();

    final data = jsonDecode(responseBody) as Map<String, dynamic>;

    final PredictResult result = PredictResult.fromJson(data);

    return ApiReturnValue(value: result, message: "success");
    // PredictResult value = PredictResult.fromJson(data);
  }
}
