import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/data/data_source/purchase_remote_datasource.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class PurchaseRemoteRepository implements IPurchaseRepository {
  final PurchaseRemoteDatasource remoteDatasource;

  PurchaseRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, String?>> createPurchase(
      PurchaseEntity purchase) async {
    try {
      final purchaseId = await remoteDatasource.createPurchase(purchase);
      return Right(purchaseId);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseEntity>>> getPurchasesByUserId(
      String userId) async {
    try {
      final purchases = await remoteDatasource.getPurchasesByUserId(userId);
      return Right(purchases);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseEntity>>> getArtistSales(
      String artistId) async {
    try {
      final sales = await remoteDatasource.getArtistSales(artistId);
      return Right(sales);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updateStatus(
      String purchaseId, String status) async {
    try {
      final success = await remoteDatasource.updateStatus(purchaseId, status);
      return Right(success);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
