import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class GetUserByIdUsecase implements UsecaseWithParams<AuthEntity, String> {
  final IAuthRepository authRepository;

  GetUserByIdUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(String id) {
    return authRepository.getCurrentUser();
  }
}
