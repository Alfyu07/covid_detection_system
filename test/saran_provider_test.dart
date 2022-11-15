import 'package:covidia/models/models.dart';
import 'package:covidia/providers/admin_provider.dart';
import 'package:covidia/providers/saran_provider.dart';
import 'package:covidia/services/admin_services.dart';
import 'package:covidia/services/saran_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSaranService extends Mock implements SaranService {}

class MockAdminService extends Mock implements AdminServices {}

void main() {
  group('Saran Service', () {
    late SaranProvider sut;
    late MockSaranService mockSaranService;

    final fakeSaran = Saran(
      id: "id",
      idUser: "idUser",
      text: "lorem ipsum sit dolor amet",
      date: DateTime.now(),
    );
    setUp(() {
      mockSaranService = MockSaranService();
      sut = SaranProvider(mockSaranService);
    });

    test('add saran function', () async {
      when(() => mockSaranService.createSaran(fakeSaran)).thenAnswer(
        (_) async => fakeSaran.id,
      );

      final result = await sut.addSaran(fakeSaran);

      expect(result, fakeSaran.id);
    });
  });

  group('Lihat Saran', () {
    late AdminProvider sut;
    late MockAdminService mockAdminService;

    final fakeSaranReturn = [
      Saran(
        id: "idSaran1",
        text: "lorem ipsum 1",
        idUser: "id User 1",
        date: DateTime.now(),
      ),
      Saran(
        id: "idSaran2",
        text: "lorem ipsum 2",
        idUser: "id User 2",
        date: DateTime.now(),
      ),
      Saran(
        id: "idSaran3",
        text: "lorem ipsum 3",
        idUser: "id User 3",
        date: DateTime.now(),
      ),
    ];
    setUp(() {
      mockAdminService = MockAdminService();
      sut = AdminProvider(mockAdminService);
    });

    void arrangeFeedbacksWith3Returns() {
      when(() => mockAdminService.queryFeedbacks("")).thenAnswer(
        (_) async => fakeSaranReturn,
      );
    }

    test('Ambil data saran', () async {
      arrangeFeedbacksWith3Returns();

      expect(sut.isLoading, false);
      final future = sut.getFeedbacks("");
      expect(sut.isLoading, true);
      await future;
      expect(sut.isLoading, false);
      expect(sut.feedbacks, fakeSaranReturn);
    });
  });
}
