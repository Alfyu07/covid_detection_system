import 'dart:io';

import 'package:covidia/models/models.dart';
import 'package:covidia/providers/providers.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:covidia/services/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';

class MockStorageService extends Mock implements StorageService {}

class MockDiagnoseService extends Mock implements DiagnoseService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Diagnose Provider Test', () {
    late MockDiagnoseService mockDiagnoseService;
    late MockStorageService mockStorageService;
    late DiagnoseProvider sut;

    late File testImage;

    const fakePredictResult = PredictResult([0.2, 0.7, 0.1], 'normal', 1);

    const fakeResponse =
        ApiReturnValue(value: fakePredictResult, message: "success");

    setUp(() async {
      mockStorageService = MockStorageService();
      mockDiagnoseService = MockDiagnoseService();
      sut = DiagnoseProvider(mockDiagnoseService, mockStorageService);
      testImage = await getImageFileFromAssets('ct_covid1.png');
    });

    test(
      "add image to diagnose",
      () async {
        when(() async => mockDiagnoseService.classifyImage(testImage))
            .thenAnswer(
          (_) async => Future.value(fakeResponse),
        );

        final result = await sut.classifyImage(testImage);
        expect(result, equals(fakeResponse));
      },
    );
  });
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}
