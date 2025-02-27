import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

abstract interface class IPurchaseRepository {
  Future<Either<Failure, List<PurchaseEntity>>> getPurchasesByUserId(String id);
  Future<Either<Failure, void>> createPurchase(PurchaseEntity purchase);
  Future<Either<Failure, List<PurchaseEntity>>> getArtistSales(String artistId);
}
