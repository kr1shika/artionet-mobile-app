import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

abstract interface class IPurchaseDataSource {
  Future<List<PurchaseEntity>> getPurchasesByUserId(String id);
  Future<String?> createPurchase(PurchaseEntity purchase);
}
