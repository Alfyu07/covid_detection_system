import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagnoseService', () {
    late FakeFirebaseFirestore? fakeFirebaseFirestore;

    const Map<String, dynamic> data = {'data': '42'};

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test('get diagnoses history from diagnose collection', () async {
      final DiagnoseService firestoreService =
          DiagnoseService(fakeFirebaseFirestore!);

      const String collectionPath = 'diagnosis';

      final CollectionReference<Map<String, dynamic>> collectionReference =
          fakeFirebaseFirestore!.collection(collectionPath);

      await collectionReference.add(data);

      final Stream<QuerySnapshot<Map<String, dynamic>>> expectedSnapshotStream =
          collectionReference.snapshots();

      final actualSnapshotStream = firestoreService.readDiagnoses();

      final QuerySnapshot<Map<String, dynamic>> expectedQuerySnapshot =
          await expectedSnapshotStream.first;

      final QuerySnapshot<Map<String, dynamic>> actualQuerySnapshot =
          await actualSnapshotStream.first;

      final List<Map<String, dynamic>> expectedDataList =
          expectedQuerySnapshot.docs.map((e) => e.data()).toList();
      final List<Map<String, dynamic>> actualDataList =
          actualQuerySnapshot.docs.map((e) => e.data()).toList();

      expect(actualDataList, expectedDataList);
    });
  });
}

class MapListContains extends Matcher {
  final Map<dynamic, dynamic> _expected;

  const MapListContains(this._expected);

  @override
  Description describe(Description description) {
    return description.add('contains ').addDescriptionOf(_expected);
  }

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is List<Map>) {
      return item.any((element) => mapEquals(element, _expected));
    }
    return false;
  }
}

// void main() {
//   late DiagnoseProvider sut;
//   late FakeFirebaseFirestore fakeFirebaseFirestore;
//   late MockDiagnosesService mockDiagnosesService;
//   late MockStorageService mockStorageService;

//   setUp(() {
//     fakeFirebaseFirestore = FakeFirebaseFirestore();
//     mockDiagnosesService = MockDiagnosesService();
//     mockStorageService = MockStorageService();
//     sut = DiagnoseProvider(mockDiagnosesService, mockStorageService);
//   });

//   test('initial values are correct', () {
//     expect(sut.isLoading, false);
//     expect(sut.image, null);
//   });

//   group('getArticles', () {
//     test(
//       "get diagnoses using DiagnosesService",
//       () async {
//         // when(() => mockDiagnosesService.readDiagnoses())
//         //     .thenAnswer((_) => );
//         sut.readDiagnoses();
//         verify(() => mockDiagnosesService.readDiagnoses()).called(1);
//       },
//     );
//   });
// }
