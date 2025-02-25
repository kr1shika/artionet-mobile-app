import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_remote_datasource.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:tryproject/features/artwork/domain/repository/artwork_repository.dart';

class ArtworkRemoteRepository implements IArtworkRepository {
  final ArtworkRemoteDatasource remoteDataSource;
  ArtworkRemoteRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getArtworks() async {
    try {
      final artworks = await remoteDataSource.getArtworks();
      return Right(artworks);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ArtworkEntity>> getArtworkById(String id) async {
    try {
      final artwork = await remoteDataSource.getArtworkById(id);
      return Right(artwork);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ArtworkEntity>> createNewArtwork(
      ArtworkEntity artwork) async {
    try {
      final newArtwork = await remoteDataSource.createNewArtwork(artwork);
      return Right(newArtwork);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadArtImage(File file) async {
    try {
      final imageName = await remoteDataSource.uploadArtImage(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ArtworkEntity>>> getArtworksbyUserId(
      String id) async {
    try {
      final artworks = await remoteDataSource.getArtworksbyUserId(id);
      return Right(artworks);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteArtworkbyId(String id) async {
    try {
      await remoteDataSource.deleteArtworkbyId(id);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
