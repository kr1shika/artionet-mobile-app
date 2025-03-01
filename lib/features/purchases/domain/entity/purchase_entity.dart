import 'package:equatable/equatable.dart';

class PurchaseEntity extends Equatable {
  final String? purchaseId;
  final String art_id;
  final String buyer_id;
  final String address;
  final String status;
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final String? totalAmount;
  final String? imageUrl;
  final String? title;

  const PurchaseEntity(
      {this.purchaseId,
      required this.art_id,
      required this.buyer_id,
      required this.address,
      required this.status,
      this.otp,
      this.otp_expiration,
      this.orderDate,
      this.totalAmount,
      this.imageUrl,
      this.title});

  PurchaseEntity copyWith({
    String? purchaseId,
    String? art_id,
    String? buyer_id,
    String? address,
    String? status,
    String? title,
    String? imageUrl,
    String? totalAmount,
  }) {
    return PurchaseEntity(
      purchaseId: purchaseId ?? this.purchaseId,
      art_id: art_id ?? this.art_id,
      buyer_id: buyer_id ?? this.buyer_id,
      address: address ?? this.address,
      status: status ?? this.status,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  const PurchaseEntity.empty()
      : purchaseId = '_empty.purchaseId',
        art_id = '_empty.art_id',
        buyer_id = '_empty.buyer_id',
        address = '_empty.address',
        status = '_empty.status',
        otp = '_empty.otp',
        otp_expiration = null,
        orderDate = null,
        imageUrl = '_empty.imagwUrl',
        totalAmount = 'null',
        title = '_empty.title';

  @override
  // TODO: implement props
  List<Object?> get props => [
        purchaseId,
        art_id,
        buyer_id,
        address,
        status,
        otp,
        otp_expiration,
        orderDate,
        totalAmount,
        imageUrl,
        title
      ];
}
