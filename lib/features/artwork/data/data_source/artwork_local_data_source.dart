import 'dart:io';

import 'package:hive_flutter/adapters.dart';
import 'package:tryproject/core/network/hive_service.dart';
import 'package:tryproject/core/util/img_downloader.dart';
import 'package:tryproject/features/artwork/data/data_source/artwork_datasource.dart';
import 'package:tryproject/features/artwork/data/model/artwork_hive_model.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';

class ArtworkLocalDataSource implements IArtworkDataSource {
  final HiveService _hiveService;
  ArtworkLocalDataSource(this._hiveService);

  @override
  Future<void> saveAllArtworks(List<ArtworkEntity> artworks) async {
    try {
      // Convert ArtworkEntity to ArtworkHiveModel and handle images
      List<ArtworkHiveModel> hiveModels = await Future.wait(
        artworks.map((artwork) async {
          String? imagePath = artwork.images != null
              ? await downloadAndSaveImage(artwork.images!)
              : null;
          return ArtworkHiveModel(
            id: artwork.artworkId,
            title: artwork.title,
            dimensions: artwork.dimensions,
            price: artwork.price,
            medium_used: artwork.medium_used,
            images: imagePath,
            archive: artwork.archive,
            isLiked: artwork.isLiked,
            artistId: artwork.artistId,
            categories: artwork.categories,
            creatorsNote: artwork.creatorsNote,
          );
        }).toList(),
      );

      // Save to Hive
      var box = await Hive.openBox<ArtworkHiveModel>('artworkBox');
      await box.addAll(hiveModels);
    } catch (e) {
      throw Exception('Error saving artworks to Hive: $e');
    }
  }

  @override
  Future<ArtworkEntity> createNewArtwork(ArtworkEntity artwork) {
    // TODO: implement createNewArtwork
    throw UnimplementedError();
  }

  @override
  Future<void> deleteArtworkbyId(String id) {
    // TODO: implement deleteArtworkbyId
    throw UnimplementedError();
  }

  @override
  Future<ArtworkEntity> getArtworkById(String id) {
    // TODO: implement getArtworkById
    throw UnimplementedError();
  }

  @override
  Future<List<ArtworkEntity>> getArtworks() async {
    try {
      // Fetch all artworks from Hive
      var box = await Hive.openBox<ArtworkHiveModel>('artworkBox');
      List<ArtworkHiveModel> hiveModels = box.values.toList();

      // Convert hive models to artwork entities
      List<ArtworkEntity> artworks = hiveModels.map((hiveModel) {
        return ArtworkEntity(
          artworkId: hiveModel.id,
          title: hiveModel.title ?? '',
          dimensions: hiveModel.dimensions,
          price: hiveModel.price,
          medium_used: hiveModel.medium_used,
          images: hiveModel.images,
          archive: hiveModel.archive,
          isLiked: hiveModel.isLiked,
          artistId: hiveModel.artistId,
          categories: hiveModel.categories,
          creatorsNote: hiveModel.creatorsNote,
        );
      }).toList();

      return artworks;
    } catch (e) {
      throw Exception('Error fetching artworks from Hive: $e');
    }
  }

  @override
  Future<List<ArtworkEntity>> getArtworksbyUserId(String id) {
    // TODO: implement getArtworksbyUserId
    throw UnimplementedError();
  }

  @override
  Future<List<ArtworkEntity>> searchArtworks(String query) {
    // TODO: implement searchArtworks
    throw UnimplementedError();
  }

  @override
  Future<ArtworkEntity> updateArtwork(ArtworkEntity artwork) {
    // TODO: implement updateArtwork
    throw UnimplementedError();
  }

  @override
  Future<String> uploadArtImage(File file) {
    // TODO: implement uploadArtImage
    throw UnimplementedError();
  }
}
