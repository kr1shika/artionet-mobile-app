import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class DeleteUserByIdUseCase {
  final IAuthRepository repository;

  DeleteUserByIdUseCase(this.repository);

  Future<Either<Failure, void>> call(String userId) {
    return repository.deleteUser(userId);
  }
}