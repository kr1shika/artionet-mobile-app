import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/purchases/data/data_source/purchase_datasource.dart';
import 'package:tryproject/features/purchases/data/model/purchase_api_model.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

class PurchaseRemoteDatasource implements IPurchaseDataSource {
  final Dio _dio;

  PurchaseRemoteDatasource({required Dio dio}) : _dio = dio;

  // Request OTP (does not create a purchase yet)
  Future<void> requestPurchaseOTP(PurchaseEntity purchase) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.requestPurchaseOTP,
        data: {
          "art_id": purchase.art_id,
          "buyer_id": purchase.buyer_id,
          "address": purchase.address,
        },
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Verify OTP and Create Purchase
  Future<void> verifyPurchase(String artId, String buyerId, String address, String otp) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.verifyPurchase,
        data: {
          "art_id": artId,
          "buyer_id": buyerId,
          "address": address,
          "otp": otp,
        },
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<PurchaseEntity>> getPurchasesByUserId(String id) {
    // TODO: implement getPurchasesByUserId
    throw UnimplementedError();
  }
  
  // @override
  // Future<void> createPurchase(PurchaseEntity purchase) {
  //   // TODO: implement createPurchase
  //   throw UnimplementedError();
  // }
}
