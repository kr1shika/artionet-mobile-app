import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';

abstract interface class IArtworkRepository {
  Future<Either<Failure, List<ArtworkEntity>>> getArtworks();
  Future<Either<Failure, ArtworkEntity>> getArtworkById(String id);
  Future<Either<Failure, ArtworkEntity>> createNewArtwork(
      ArtworkEntity artwork, File imageFile);
  Future<Either<Failure, String>> uploadArtImage(File file);
}
