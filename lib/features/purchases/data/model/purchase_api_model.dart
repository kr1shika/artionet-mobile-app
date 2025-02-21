import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/purchases/domain/entity/purchase_entity.dart';

part 'purchase_api_model.g.dart';

@JsonSerializable()
class PurchaseApiModel extends Equatable {
  @JsonKey(name: '_id')
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

  const PurchaseApiModel({
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

  factory PurchaseApiModel.fromJson(Map<String, dynamic> json) {
    return PurchaseApiModel(
        purchaseId: json['_id'],
        art_id: json['art_id'],
        buyer_id: json['buyer_id'],
        address: json['address'],
        status: json["status"],
        phone_number: json['phone_number'],
        otp: json["otp"],
        otp_expiration: json['otp_expiration'],
        orderDate: json['orderDate'],
        totalAmount: json['totalAmount']);
  }

  Map<String, dynamic> toJson() {
    return {
      'art_id': art_id,
      'buyer_id': buyer_id,
      'address': address,
      'status': "status",
      'phone_number': phone_number,
      'otp': "otp",
      'otp_expiration': otp_expiration,
      'orderDate': orderDate,
      'totalAmount': totalAmount
    };
  }

  factory PurchaseApiModel.fromEntity(PurchaseEntity entity) =>
      PurchaseApiModel(
          purchaseId: entity.purchaseId ?? '',
          art_id: entity.art_id,
          buyer_id: entity.buyer_id,
          address: entity.address,
          status: entity.status,
          phone_number: entity.phone_number,
          otp: entity.otp,
          otp_expiration: entity.otp_expiration,
          orderDate: entity.orderDate,
          totalAmount: entity.totalAmount);

  PurchaseEntity toEntity() => PurchaseEntity(
      purchaseId: purchaseId,
      art_id: art_id,
      buyer_id: buyer_id,
      address: address,
      status: status,
      phone_number: phone_number,
      otp: otp,
      otp_expiration: otp_expiration,
      orderDate: orderDate,
      totalAmount: totalAmount);

  static List<PurchaseEntity> toEntityList(List<PurchaseApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
