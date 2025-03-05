import 'dart:io';

import 'package:hive/hive.dart';
import 'package:tryproject/app/constants/hive_table_constant.dart';
import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_datasource.dart';
import 'package:tryproject/features/artwork/data/model/artwork_hive_model.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';

class ArtworkLocalDataSource implements IArtworkDataSource {
  final HiveService hiveService;

  ArtworkLocalDataSource(this.hiveService);

  @override
  Future<List<ArtworkEntity>> getArtworks() async {
    try {
      final box =
          await Hive.openBox<ArtworkHiveModel>(HiveTableConstant.artworkBox);
      final artworks = box.values.map((model) => model.toEntity()).toList();
      return artworks;
    } catch (e) {
      throw Exception('Failed to fetch artworks from Hive: $e');
    }
  }

  @override
  Future<void> saveAllArtworks(List<ArtworkEntity> artworks) async {
    try {
      final box =
          await Hive.openBox<ArtworkHiveModel>(HiveTableConstant.artworkBox);
      await box.clear();
      await box.addAll(artworks
          .map((entity) => ArtworkHiveModel.fromEntity(entity))
          .toList());
    } catch (e) {
      throw Exception('Failed to save artworks to Hive: $e');
    }
  }

  @override
  Future<ArtworkEntity> getArtworkById(String id) async {
    throw UnimplementedError(
        'getArtworkById is not implemented in local data source');
  }

  @override
  Future<ArtworkEntity> createNewArtwork(ArtworkEntity artwork) async {
    throw UnimplementedError(
        'createNewArtwork is not implemented in local data source');
  }

  @override
  Future<String> uploadArtImage(File file) async {
    throw UnimplementedError(
        'uploadArtImage is not implemented in local data source');
  }

  @override
  Future<List<ArtworkEntity>> getArtworksbyUserId(String id) async {
    throw UnimplementedError(
        'getArtworksbyUserId is not implemented in local data source');
  }

  @override
  Future<void> deleteArtworkbyId(String id) async {
    throw UnimplementedError(
        'deleteArtworkbyId is not implemented in local data source');
  }

  @override
  Future<ArtworkEntity> updateArtwork(ArtworkEntity artwork) async {
    throw UnimplementedError(
        'updateArtwork is not implemented in local data source');
  }

  @override
  Future<List<ArtworkEntity>> searchArtworks(String query) async {
    throw UnimplementedError(
        'searchArtworks is not implemented in local data source');
  }
}
