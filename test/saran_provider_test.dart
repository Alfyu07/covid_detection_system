import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/providers/saran_provider.dart';
import 'package:covidia/services/saran_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaranService extends Mock implements SaranService {}

// ignore: subtype_of_sealed_class
class MockCollectionReference extends Mock implements CollectionReference {}

// ignore: subtype_of_sealed_class
class MockDocumentReference extends Mock implements DocumentReference {}

// ignore: subtype_of_sealed_class
class MockDocumentSnapshot extends Mock implements DocumentSnapshot {}

void main() {
  late SaranProvider sut;
  late MockSaranService mockSaranService;

  setUp(() {
    mockSaranService = new MockSaranService();
  });
}
