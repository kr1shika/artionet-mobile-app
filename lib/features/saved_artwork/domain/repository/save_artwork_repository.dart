import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';

abstract interface class ISaveArtsRepository {
  Future<Either<Failure, List<SaveArtworkEntity>>> getCollection(
      String buyerId);
  Future<Either<Failure, void>> save(SaveArtworkEntity collection);
  Future<Either<Failure, void>> removeFromCollection(
      String artId, String buyerId);
}
