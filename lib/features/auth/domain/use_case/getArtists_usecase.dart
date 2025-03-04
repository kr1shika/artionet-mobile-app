import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class GetartistsUsecase implements UsecaseWithoutParams<List<AuthEntity>> {
  final IAuthRepository authRepository;

  GetartistsUsecase({required this.authRepository});

  @override
  Future<Either<Failure, List<AuthEntity>>> call() {
    return authRepository.getArtists();
  }
}
