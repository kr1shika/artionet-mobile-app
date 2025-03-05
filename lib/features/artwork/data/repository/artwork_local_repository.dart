import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_local_data_source.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class ArtworkLocalRepository implements IArtworkRepository {
  final ArtworkLocalDataSource _artworkLocalDatasource;

  ArtworkLocalRepository(this._artworkLocalDatasource);

  @override
  Future<Either<Failure, ArtworkEntity>> createNewArtwork(
      ArtworkEntity artwork) {
    // TODO: implement createNewArtwork
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteArtworkbyId(String id) {
    // TODO: implement deleteArtworkbyId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ArtworkEntity>> getArtworkById(String id) {
    // TODO: implement getArtworkById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getArtworks() async {
    try {
      // Call the data source to get the artworks
      final artworks = await _artworkLocalDatasource.getArtworks();

      // Return the list of artworks wrapped in Either (success)
      return Right(artworks);
    } catch (e) {
      // If there is an error, return a failure wrapped in Either (error)
      return Left(LocalDatabaseFailure(message: 'Error getting artworks: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getArtworksbyUserId(String id) {
    // TODO: implement getArtworksbyUserId
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> searchArtworks(String query) {
    // TODO: implement searchArtworks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, ArtworkEntity>> updateArtwork(ArtworkEntity artwork) {
    // TODO: implement updateArtwork
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadArtImage(File file) {
    // TODO: implement uploadArtImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> saveAllArtworks(
      List<ArtworkEntity> artworks) async {
    try {
      // Call the data source to save all artworks
      await _artworkLocalDatasource.saveAllArtworks(artworks);
      return const Right(
          null); // Successfully saved artworks, return null (void)
    } catch (e) {
      // If there's an error, return a failure wrapped in Either (error)
      return Left(LocalDatabaseFailure(message: 'Error saving artworks: $e'));
    }
  }
}
