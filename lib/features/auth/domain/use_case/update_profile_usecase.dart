import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class UpdateProfileUseCase {
  final IAuthRepository _authRepository;

  UpdateProfileUseCase(this._authRepository);

  Future<Either<Failure, AuthEntity>> call(AuthEntity artist) async {
    return await _authRepository.updateProfile(artist);
  }
}
