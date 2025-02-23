import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tryproject/app/usecase/usecase.dart';
import 'package:tryproject/core/error/failure.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';
import 'package:tryproject/features/purchases/domain/repository/purchase_repository.dart';

class CreatePurchaseUserParams extends Equatable {
  final String art_id;
  final String? purchaseId;
  final String buyer_id;
  final String address;
  final String status;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final String? totalAmount;

  const CreatePurchaseUserParams({
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    this.purchaseId,
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
        purchaseId
      ];
}

class CreatePurchaseUsecase
    implements UsecaseWithParams<String?, CreatePurchaseUserParams> {
  final IPurchaseRepository repository;

  CreatePurchaseUsecase(this.repository);

  @override
  Future<Either<Failure, String?>> call(CreatePurchaseUserParams params) async {
    final purchaseEntity = PurchaseEntity(
      art_id: params.art_id,
      buyer_id: params.buyer_id,
      address: params.address,
      status: params.status,
    );

    final result = await repository.createPurchase(purchaseEntity);

    return result.fold(
      (failure) => Left(failure),
      (_) => Right(purchaseEntity.purchaseId), // ✅ Return purchaseId
    );
  }
}
