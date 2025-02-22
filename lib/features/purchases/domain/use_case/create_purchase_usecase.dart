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
  final String phone_number;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final int? totalAmount;

  const CreatePurchaseUserParams({
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    required this.phone_number,
    this.otp,
    this.otp_expiration,
    this.orderDate,
    this.totalAmount,
  });

  const CreatePurchaseUserParams.initial(
    this.otp,
    this.otp_expiration,
    this.orderDate,
    this.totalAmount, {
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    required this.phone_number,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        art_id,
        buyer_id,
        address,
        status,
        phone_number,
        otp,
        otp_expiration,
        orderDate,
        totalAmount
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
        phone_number: params.phone_number,
        otp: params.otp,
        otp_expiration: params.otp_expiration,
        orderDate: params.orderDate,
        totalAmount: params.totalAmount);
    return repository.createPurchase(purchaseEntity);
  }
}
