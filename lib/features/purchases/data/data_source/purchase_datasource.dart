import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

abstract interface class IPurchaseDataSource {
  Future<List<PurchaseEntity>> getPurchasesByUserId(String id);
  Future<void> requestPurchaseOTP(PurchaseEntity purchase);
  Future<void> verifyPurchase(
      String artId, String otp, String address, String buyerId);
}
