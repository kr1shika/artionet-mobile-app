import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/auth/domain/repository/auth_repository.dart';

class uploadImageParams {
  final File file;
  const uploadImageParams({
    required this.file,
  });
}

class UploadImageUsecase
    implements UsecaseWithParams<String, uploadImageParams> {
  final IAuthRepository _repository;

  UploadImageUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(uploadImageParams params) {
    return _repository.uploadProfilePicture(params.file);
  }
}
