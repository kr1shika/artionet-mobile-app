import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';

abstract interface class IArtworkDataSource {
  Future<List<ArtworkEntity>> getArtworks();
  Future<ArtworkEntity> getArtworkById(String id);
}
