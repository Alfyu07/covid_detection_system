import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagnoseService', () {
    late FakeFirebaseFirestore? fakeFirebaseFirestore;

    final Diagnosis fakeDiagnosis = Diagnosis(
      confidence: const [0.1, 0.2, 0.7],
      id: "id",
      imgUrl: "",
      label: "pneumonia",
      index: 2,
      date: DateTime.now(),
    );

    setUp(() {
      fakeFirebaseFirestore = FakeFirebaseFirestore();
    });

    test('Search existing data with query', () async {
      final DiagnoseService diagnoseService =
          DiagnoseService(fakeFirebaseFirestore!);
      const String collectionPath = 'diagnosis';

      await fakeFirebaseFirestore!
          .collection(collectionPath)
          .add(fakeDiagnosis.toJson());

      final List<Map<String, dynamic>> dataList =
          (await diagnoseService.queryData("id"))
              .docs
              .map((e) => e.data())
              .toList();

      expect(
        dataList.any((element) => Diagnosis.fromJson(element) == fakeDiagnosis),
        true,
      );
    });
    test('Search nonExisting data with query', () async {
      final DiagnoseService diagnoseService =
          DiagnoseService(fakeFirebaseFirestore!);
      const String collectionPath = 'diagnosis';

      await fakeFirebaseFirestore!
          .collection(collectionPath)
          .add(fakeDiagnosis.toJson());

      final List<Map<String, dynamic>> dataList =
          (await diagnoseService.queryData("awaw"))
              .docs
              .map((e) => e.data())
              .toList();

      expect(
        dataList.any((element) => Diagnosis.fromJson(element) == fakeDiagnosis),
        false,
      );
    });

    test('get diagnoses history from diagnose collection', () async {
      final DiagnoseService diagnoseService =
          DiagnoseService(fakeFirebaseFirestore!);

      const String collectionPath = 'diagnosis';

      final CollectionReference<Map<String, dynamic>> collectionReference =
          fakeFirebaseFirestore!.collection(collectionPath);

      await collectionReference.add(fakeDiagnosis.toJson());

      final Stream<QuerySnapshot<Map<String, dynamic>>> expectedSnapshotStream =
          collectionReference.snapshots();

      final actualSnapshotStream = diagnoseService.readDiagnoses(10);

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

  MapListContains(this._expected);

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
