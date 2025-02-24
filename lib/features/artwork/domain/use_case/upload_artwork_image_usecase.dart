import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class uploadArtworkImageParams {
  final File file;
  const uploadArtworkImageParams({
    required this.file,
  });
}

class UploadArtworkUsecase
    implements UsecaseWithParams<String, uploadArtworkImageParams> {
  final IArtworkRepository _artwork_repository;

  UploadArtworkUsecase(this._artwork_repository);

  @override
  Future<Either<Failure, String>> call(uploadArtworkImageParams params) {
    return _artwork_repository.uploadArtImage(params.file);
  }
}
