import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/entity/auth_entity.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class UpdateProfileParams extends Equatable {
  final String userId;
  final String fullName;
  final String contactNo;
  final String email;
  final String? profilePic;

  const UpdateProfileParams({
    required this.userId,
    required this.fullName,
    required this.contactNo,
    required this.email,
    this.profilePic,
  });

  @override
  List<Object?> get props => [
        userId,
        fullName,
        contactNo,
        email,
        profilePic,
      ];
}

class UpdateProfileUseCase
    implements UsecaseWithParams<AuthEntity, UpdateProfileParams> {
  final IAuthRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(UpdateProfileParams params) {
    final authEntity = AuthEntity(
      userId: params.userId,
      full_name: params.fullName,
      contact_no: params.contactNo,
      email: params.email,
      profilepic: params.profilePic, password: '',
    );
    return repository.updateProfile(authEntity);
  }
}
