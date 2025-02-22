import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class VerifyPurchaseParams extends Equatable {
  final String purchaseId;
  final String otp;

  const VerifyPurchaseParams({required this.purchaseId, required this.otp});

  @override
  List<Object?> get props => [purchaseId, otp];
}

class VerifyPurchaseUsecase implements UsecaseWithParams<void, VerifyPurchaseParams> {
  final IPurchaseRepository repository;

  VerifyPurchaseUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyPurchaseParams params) {
    return repository.verifyPurchase(params.purchaseId, params.otp);
  }
}
