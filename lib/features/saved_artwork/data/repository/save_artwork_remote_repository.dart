import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/saved_artwork/data/data_source/save_artwork_remote_datasource.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';
import 'package:tryproject/features/saved_artwork/domain/repository/save_artwork_repository.dart';

class SaveArtworkRemoteRepository implements ISaveArtsRepository {
  final SaveArtworkRemoteDatasource remoteDatasource;

  SaveArtworkRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<SaveArtworkEntity>>> getCollection(
      String buyerId) async {
    try {
      final collection = await remoteDatasource.getCollection(buyerId);
      return Right(collection);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCollection(
      String artId, String buyerId) async {
    try {
      await remoteDatasource.removeFromCollection(artId, buyerId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> save(SaveArtworkEntity collection) async {
    try {
      await remoteDatasource.save(collection);
      return const Right(null); // No value needed, just success indication
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkStatus(
      String artId, String buyerId) async {
    try {
      final isLiked = await remoteDatasource.checkStatus(artId, buyerId);
      return Right(isLiked);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
