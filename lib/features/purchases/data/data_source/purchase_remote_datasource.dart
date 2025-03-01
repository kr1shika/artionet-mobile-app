import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/purchases/data/data_source/purchase_datasource.dart';
import 'package:tryproject/features/purchases/data/dto/purchase_with_artwork_response_dto.dart';
import 'package:tryproject/features/purchases/data/model/purchase_api_model.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

class PurchaseRemoteDatasource implements IPurchaseDataSource {
  final Dio _dio;

  PurchaseRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<String?> createPurchase(PurchaseEntity purchase) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.createPurchase,
        data: {
          "art_id": purchase.art_id,
          "buyer_id": purchase.buyer_id,
          "address": purchase.address,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        return responseData['purchaseId'] as String?;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PurchaseEntity>> getPurchasesByUserId(String userId) async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.getPurchasesByUserId}/$userId');
      if (response.statusCode == 200) {
        // Parse the response using the DTO
        PurchaseWithArtworkResponseDTO responseDTO =
            PurchaseWithArtworkResponseDTO.fromJson(response.data);
        return PurchaseApiModel.toEntityList(responseDTO.data);
      } else {
        throw Exception('Failed to load purchases');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PurchaseEntity>> getArtistSales(String artistId) async {
    try {
      final response =
          await _dio.get('${ApiEndpoints.getArtistSales}/$artistId');
      if (response.statusCode == 200) {
        // Parse the response using the DTO
        PurchaseWithArtworkResponseDTO responseDTO =
            PurchaseWithArtworkResponseDTO.fromJson(response.data);
        return PurchaseApiModel.toEntityList(responseDTO.data);
      } else {
        throw Exception('Failed to load artist sales');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> updateStatus(String purchaseId, String status) async {
    try {
      final response = await _dio.put(
        ApiEndpoints.updateStatus,
        data: {
          "purchaseId": purchaseId,
          "status": status,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update purchase status');
      }
    } on DioException catch (e) {
      throw Exception(e);
    }
  }
}
