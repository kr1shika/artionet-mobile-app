import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase implements UsecaseWithoutParams<AuthEntity> {
  final IAuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call() {
    return repository.getCurrentUser();
  }
}
