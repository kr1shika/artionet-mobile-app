import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class CreatePurchaseUserParams extends Equatable {
  final String art_id;
  final String buyer_id;
  final String address;
  final String status;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final int? totalAmount;

  const CreatePurchaseUserParams({
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    this.otp,
    this.otp_expiration,
    this.orderDate,
    this.totalAmount,
  });

  @override
  List<Object?> get props => [
        art_id,
        buyer_id,
        address,
        status,
        otp,
        otp_expiration,
        orderDate,
        totalAmount,
      ];
}

class CreatePurchaseUsecase
    implements UsecaseWithParams<void, CreatePurchaseUserParams> {
  final IPurchaseRepository repository;

  CreatePurchaseUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(CreatePurchaseUserParams params) {
    final purchaseEntity = PurchaseEntity(
        art_id: params.art_id,
        buyer_id: params.buyer_id,
        address: params.address,
        status: params.status,
        otp: params.otp,
        otp_expiration: params.otp_expiration,
        orderDate: params.orderDate,
        totalAmount: params.totalAmount);
    return repository.requestPurchaseOTP(purchaseEntity);
  }
}
