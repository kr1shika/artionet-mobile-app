import 'package:equatable/equatable.dart';

class PurchaseEntity extends Equatable {
  final String? purchaseId;
  final String art_id;
  final String buyer_id;
  final String address;
  final String status;
  final String phone_number;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final int? totalAmount;

  const PurchaseEntity({
    this.purchaseId,
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

  const PurchaseEntity.empty()
      : purchaseId = '_empty.purchaseId',
        art_id = '_empty.art_id',
        buyer_id = '_empty.buyer_id',
        address = '_empty.address',
        status = '_empty.status',
        phone_number = '_empty.phone_number',
        otp = '_empty.otp',
        otp_expiration = null,
        orderDate = null,
        totalAmount = null;

  @override
  // TODO: implement props
  List<Object?> get props => [
        purchaseId,
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
