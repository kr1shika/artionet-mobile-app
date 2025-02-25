import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/saved_artwork/data/data_source/save_artwork_datasource.dart';
import 'package:tryproject/features/saved_artwork/domain/entity/save_artwork_entity.dart';

class SaveArtworkRemoteDatasource implements ISaveArtsDataSource {
  final Dio _dio;

  SaveArtworkRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<List<SaveArtworkEntity>> getCollection(String buyerId) {
    // TODO: implement getCollection
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromCollection(String artId, String buyerId) async {
    try {
      final response = await _dio.delete(
        ApiEndpoints.removeFromCollection,
        data: {
          "art_id": artId,
          "buyer_id": buyerId,
        },
        options: Options(headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Failed to remove artwork from collection: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<String?> save(SaveArtworkEntity collection) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.save,
        data: {
          "art_id": collection.art_id,
          "buyer_id": collection.buyer_id,
        },
        // options: Options(headers: {
        //   "Accept": "application/json",
        //   "Content-Type": "application/json",
        // }),
      );

      if (response.statusCode == 201) {
        return response.data['_id'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Failed to save artwork: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  @override
  Future<bool> checkStatus(String artId, String buyerId) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.checkStatus,
        data: {
          "art_id": artId,
          "buyer_id": buyerId,
        },
      );

            print("API Response: ${response.data}");

      if (response.statusCode == 200) {
        return response.data['isLiked'] ?? false;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception("Failed to check artwork status: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
