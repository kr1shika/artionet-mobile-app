import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class VerifyPurchaseParams extends Equatable {
  final String art_id;
  final String buyer_id;
  final String address;
  final String otp;

  const VerifyPurchaseParams({
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.otp,
  });

  @override
  List<Object?> get props => [art_id, buyer_id, address, otp];
}

class VerifyPurchaseUsecase
    implements UsecaseWithParams<void, VerifyPurchaseParams> {
  final IPurchaseRepository repository;

  VerifyPurchaseUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(VerifyPurchaseParams params) {
    return repository.verifyPurchase(
        params.art_id, params.buyer_id, params.address, params.otp);
  }
}
