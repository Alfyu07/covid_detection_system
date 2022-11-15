import 'dart:io';

import 'package:covidia/models/models.dart';
import 'package:covidia/providers/providers.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:covidia/services/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'mock_path_provider_paltform.dart';

class MockStorageService extends Mock implements StorageService {}

class MockDiagnoseService extends Mock implements DiagnoseService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Diagnose Provider Test', () {
    late MockDiagnoseService mockDiagnoseService;
    late MockStorageService mockStorageService;
    late DiagnoseProvider sut;

    late File testImage;

    final fakePredictResult = PredictResult(
      confidence: [0.2, 0.7, 0.1],
      prediction: 'normal',
      index: 1,
    );

    final fakeResponse =
        ApiReturnValue(value: fakePredictResult, message: "success");

    final fakeDiagnose = Diagnosis(
      id: "diagnoseId",
      date: DateTime.now(),
      index: 1,
      confidence: const [0.2, 0.7, 0.1],
      label: "normal",
    );

    setUp(() async {
      PathProviderPlatform.instance = FakePathProviderPlatform();
      mockStorageService = MockStorageService();
      mockDiagnoseService = MockDiagnoseService();
      sut = DiagnoseProvider(mockDiagnoseService, mockStorageService);
      testImage = await getImageFileFromAssets('ct_covid1.png');
    });

    test("add image to diagnose", () async {
      //arrange
      when(() => mockDiagnoseService.classifyImage(testImage))
          .thenAnswer((_) async => fakeResponse);
      //act
      final result = await sut.classifyImage(testImage);
      //assets
      expect(result, fakeResponse);
    });

    test('add Diagnosis data to database', () async {
      when(() => mockDiagnoseService.createDiagnosis(fakeDiagnose)).thenAnswer(
        (_) async => fakeDiagnose.id,
      );

      final result = await sut.addDiagnoses(fakeDiagnose);
      expect(result, fakeDiagnose.id);
    });

    test('upload image to storage', () async {
      const path = 'images/predicted_image/image1.png';
      when(
        () => mockStorageService.uploadImage(
          path,
          testImage,
        ),
      ).thenAnswer(
        (_) async => path,
      );

      final result = await sut.uploadImage(path, testImage);
      expect(result, path);
    });
  });
}

Future<File> getImageFileFromAssets(String path) async {
  final byteData = await rootBundle.load('assets/$path');

  final file = File('${(await getTemporaryDirectory()).path}/$path');
  await file.writeAsBytes(
    byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes),
  );

  return file;
}
