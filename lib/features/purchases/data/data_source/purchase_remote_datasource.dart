import 'package:dio/dio.dart';
import 'package:tryproject/app/constants/api_endpoints.dart';
import 'package:tryproject/features/purchases/data/data_source/purchase_datasource.dart';
import 'package:tryproject/features/purchases/data/model/purchase_api_model.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

class PurchaseRemoteDatasource implements IPurchaseDataSource {
  final Dio _dio;

  PurchaseRemoteDatasource({required Dio dio}) : _dio = dio;

  @override
  Future<void> createPurchase(PurchaseEntity purchase) async {
    try {
      // Convert entity to model
      var purchaseApiModel = PurchaseApiModel.fromEntity(purchase);
      var response = await _dio.post(
        ApiEndpoints.createPurchase,
        data: purchaseApiModel.toJson(),
      );
      if (response.statusCode == 201) {
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

    Future<void> verifyPurchase(String purchaseId, String otp) async {
    try {
      var response = await _dio.post(
        ApiEndpoints.verifyPurchase,
        data: {"purchaseId": purchaseId, "otp": otp},
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
}
