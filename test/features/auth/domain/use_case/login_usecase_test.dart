import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';
import 'package:tryproject/features/auth/domain/use_case/login_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late LoginUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = LoginUseCase(repository);
  });

  const loginParams = LoginParams(
    email: "krishika@gmail.com",
    password: "password123",
  );

  group('LoginUseCase Tests', () {
    test('should return Failure when email is invalid', () async {
      // Arrange
      when(() => repository.loginUser(loginParams.email, loginParams.password))
          .thenAnswer(
              (_) async => const Left(ApiFailure(message: "Invalid email")));

      // Act
      final result = await useCase(loginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Invalid email")));
      verify(() =>
              repository.loginUser(loginParams.email, loginParams.password))
          .called(1);
    });

    test('should return Failure when password is incorrect', () async {
      // Arrange
      when(() => repository.loginUser(loginParams.email, loginParams.password))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Incorrect password")));

      // Act
      final result = await useCase(loginParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Incorrect password")));
      verify(() =>
              repository.loginUser(loginParams.email, loginParams.password))
          .called(1);
    });

    test('should return Failure when there is a server-side issue', () async {
      // Arrange
      when(() => repository.loginUser(loginParams.email, loginParams.password))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Unexpected server error")));

      // Act
      final result = await useCase(loginParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Unexpected server error")));
      verify(() =>
              repository.loginUser(loginParams.email, loginParams.password))
          .called(1);
    });

    test('should return Failure when email is empty', () async {
      // Arrange
      const invalidParams = LoginParams(
        email: "",
        password: "password123",
      );

      when(() =>
              repository.loginUser(invalidParams.email, invalidParams.password))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Email cannot be empty")));

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Email cannot be empty")));
      verify(() =>
              repository.loginUser(invalidParams.email, invalidParams.password))
          .called(1);
    });

    test('should return Failure when password is empty', () async {
      // Arrange
      const invalidParams = LoginParams(
        email: "krishika@gmail.com",
        password: "",
      );

      when(() =>
              repository.loginUser(invalidParams.email, invalidParams.password))
          .thenAnswer((_) async =>
              const Left(ApiFailure(message: "Password cannot be empty")));

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Password cannot be empty")));
      verify(() =>
              repository.loginUser(invalidParams.email, invalidParams.password))
          .called(1);
    });
  });
}
