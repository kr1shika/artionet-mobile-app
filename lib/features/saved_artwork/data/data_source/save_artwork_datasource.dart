import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';

abstract interface class ISaveArtsDataSource {
  Future<List<SaveArtworkEntity>> getCollection(String buyerId);
  Future<String?> save(SaveArtworkEntity collection);
  Future<void> removeFromCollection(String artId, String buyerId);
  Future<bool> checkStatus(String artId, String buyerId);
}
