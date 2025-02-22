import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/data/data_source/purchase_remote_datasource.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class PurchaseRemoteRepository implements IPurchaseRepository {
  final PurchaseRemoteDatasource remoteDatasource;

  PurchaseRemoteRepository({required this.remoteDatasource});

  @override
  Future<Either<Failure, void>> requestPurchaseOTP(
      PurchaseEntity purchase) async {
    try {
      remoteDatasource.requestPurchaseOTP(purchase);
      return const Right(null);
    } catch (e) {
      return Left(
        ApiFailure(
          message: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> verifyPurchase(
      String artId, String otp, String address, String buyerId) async {
    try {
      await remoteDatasource.verifyPurchase(buyerId, artId, otp, address);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PurchaseEntity>>> getPurchasesByUserId(
      String id) {
    // TODO: implement getPurchasesByUserId
    throw UnimplementedError();
  }
}
