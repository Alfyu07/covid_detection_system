import 'package:covidia/providers/authentication_provider.dart';
import 'package:covidia/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockAuthService extends Mock implements AuthenticationService {}

class MockFirebaseUser extends Mock implements User {}

void main() {
  group('Login ', () {
    late MockAuthService mockAuthService;
    late AuthProvider sut;
    const email = "wahyu@gmail.com";
    const password = "12345678";
    const wrongEmail = "test123@gmail.com";

    setUp(() {
      mockAuthService = MockAuthService();
      sut = AuthProvider(mockAuthService);
    });

    test('Login with registered email', () async {
      when(
        () => mockAuthService.signIn(
          email,
          password,
        ),
      ).thenAnswer((_) async => "signed in");

      expect(sut.isLoading, false);
      final future = sut.signIn(email: email, password: password);
      expect(sut.isLoading, true);
      final result = await future;
      expect(sut.isLoading, false);
      expect(result, "signed in");
    });

    test('Login with unregistered email', () async {
      when(
        () => mockAuthService.signIn(
          wrongEmail,
          password,
        ),
      ).thenAnswer((_) async => "No user found with this email.");

      expect(sut.isLoading, false);
      final future = sut.signIn(email: wrongEmail, password: password);
      expect(sut.isLoading, true);
      final result = await future;
      expect(sut.isLoading, false);
      expect(result, "No user found with this email.");
    });
  });

  group('SignUp ', () {
    late MockAuthService mockAuthService;
    late AuthProvider sut;
    const fullname = "wahyu";
    const registeredEmail = "wahyu@gmail.com";
    const unregisteredEmail = "emailhanyacobacoba@gmail.com";
    const imgUrl =
        "https://media.istockphoto.com/id/1352173787/photo/sunset.jpg?b=1&s=170667a&w=0&k=20&c=jKDMxKXALm540OTFB3vMIDFYwOEedauorSpvLgjkU1M=";
    const password = "12345678";

    setUp(() {
      mockAuthService = MockAuthService();
      sut = AuthProvider(mockAuthService);
    });

    test('Sign Up with registered email', () async {
      when(
        () => mockAuthService.signUp(
          fullname: fullname,
          email: registeredEmail,
          password: password,
          imgUrl: imgUrl,
        ),
      ).thenAnswer((_) async => "failed");

      expect(sut.isLoading, false);
      final future = sut.signUp(
          fullname: fullname,
          email: registeredEmail,
          password: password,
          imgUrl: imgUrl,);
      expect(sut.isLoading, true);
      final result = await future;
      expect(sut.isLoading, false);
      expect(result, isNot(equals("Successfully signed up")));
    });

    test('Sign Up with unregistered email', () async {
      when(
        () => mockAuthService.signUp(
          fullname: fullname,
          email: unregisteredEmail,
          password: password,
          imgUrl: imgUrl,
        ),
      ).thenAnswer((_) async => "Successfully signed up");

      expect(sut.isLoading, false);
      final future = sut.signUp(
          fullname: fullname,
          email: unregisteredEmail,
          password: password,
          imgUrl: imgUrl,);
      expect(sut.isLoading, true);
      final result = await future;
      expect(sut.isLoading, false);
      expect(result, "Successfully signed up");
    });
  });
}
