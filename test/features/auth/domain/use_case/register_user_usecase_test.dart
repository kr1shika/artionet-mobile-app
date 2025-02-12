import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';
import 'package:tryproject/features/auth/domain/use_case/register_user_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = RegisterUseCase(repository);
    registerFallbackValue(const AuthEntity(
      full_name: '',
      email: '',
      contact_no: '',
      role: '',
      password: '',
      artistname: null,
      profilepic: null,
    ));
  });

  const registerParams = RegisterUserParams(
    full_name: "krishika",
    contact_no: "1234567890",
    email: "krishika@example.com",
    role: "buyer",
    password: "password123",
    artistname: null,
    profilepic: null,
  );

  group('RegisterUseCase Tests', () {
    test('should return Failure when email is already in use', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email is already registered")));

      // Act
      final result = await useCase(registerParams);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "Email is already registered")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when required fields are missing', () async {
      // Arrange
      const invalidParams = RegisterUserParams(
        full_name: "",
        contact_no: "1234567890",
        email: "krishika@example.com",
        role: "user",
        password: "password123",
        artistname: null,
        profilepic: null,
      );

      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "One or more credentials are empty")));

      // Act
      final result = await useCase(invalidParams);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "One or more credentials are empty")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when there is a server-side issue', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Unexpected server error")));

      // Act
      final result = await useCase(registerParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Unexpected server error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should successfully register a user and return Right(null)',
        () async {
      // Arrange
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await useCase(registerParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
      verifyNoMoreInteractions(repository);
    });

    test('should return Failure when contact number is invalid', () async {
      // Arrange
      const invalidContactParams = RegisterUserParams(
        full_name: "krishika",
        contact_no: "invalid",
        email: "krishika@example.com",
        role: "user",
        password: "password123",
        artistname: null,
        profilepic: null,
      );

      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Invalid contact number")));

      // Act
      final result = await useCase(invalidContactParams);

      // Assert
      expect(result, const Left(ApiFailure(message: "Invalid contact number")));
      verify(() => repository.registerUser(any())).called(1);
    });
  });
}
