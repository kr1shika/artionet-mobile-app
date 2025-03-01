import 'package:dartz/dartz.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class UpdatePurchaseStatusUseCase {
  final IPurchaseRepository repository;

  UpdatePurchaseStatusUseCase(this.repository);

  Future<Either<Failure, bool>> call(String purchaseId, String status) {
    return repository.updateStatus(purchaseId, status);
  }
}
