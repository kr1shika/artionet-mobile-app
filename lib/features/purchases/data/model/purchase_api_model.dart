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
  final String? otp;
  final DateTime? otp_expiration;
  final DateTime? orderDate;
  final String? totalAmount;
  final String? title;
  final String? imageUrl; // Make imageUrl late to initialize later if necessary

  const PurchaseApiModel({
    this.purchaseId,
    required this.art_id,
    required this.buyer_id,
    required this.address,
    required this.status,
    this.otp,
    this.otp_expiration,
    this.orderDate,
    this.totalAmount,
    this.title,
    this.imageUrl,
  });

  factory PurchaseApiModel.fromJson(Map<String, dynamic> json) {
    String? imageUrl = json['imageUrl']; // Get image URL

    // If the image URL is not a full URL, prepend the server base URL (if required)
    if (imageUrl != null && !imageUrl.startsWith('http')) {
      imageUrl =
          'http://10.0.2.2:5055/$imageUrl'; 
    }

    return PurchaseApiModel(
      purchaseId: json['purchaseId'],
      art_id: json['art_id'],
      buyer_id: json['buyer_id'],
      address: json['address'],
      status: json['status'],
      otp: json['otp'],
      otp_expiration: json['otp_expiration'] != null
          ? DateTime.parse(json['otp_expiration'])
          : null,
      orderDate:
          json['orderDate'] != null ? DateTime.parse(json['orderDate']) : null,
      totalAmount: json['totalAmount'],
      title: json['title'],
      imageUrl: imageUrl,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'art_id': art_id,
      'buyer_id': buyer_id,
      'address': address,
      'status': status,
      'otp': otp,
      'otp_expiration': otp_expiration,
      'orderDate': orderDate,
      'totalAmount': totalAmount,
      'imageUrl': imageUrl, // Include the image URL in the JSON
    };
  }

  factory PurchaseApiModel.fromEntity(PurchaseEntity entity) =>
      PurchaseApiModel(
          purchaseId: entity.purchaseId ?? '',
          art_id: entity.art_id,
          buyer_id: entity.buyer_id,
          address: entity.address,
          status: entity.status,
          otp: entity.otp,
          otp_expiration: entity.otp_expiration,
          orderDate: entity.orderDate,
          totalAmount: entity.totalAmount,
          imageUrl: entity.imageUrl);

  PurchaseEntity toEntity() => PurchaseEntity(
      purchaseId: purchaseId,
      art_id: art_id,
      buyer_id: buyer_id,
      address: address,
      status: status,
      otp: otp,
      otp_expiration: otp_expiration,
      orderDate: orderDate,
      totalAmount: totalAmount,
      imageUrl: imageUrl);

  static List<PurchaseEntity> toEntityList(List<PurchaseApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
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
        title,
        imageUrl
      ];
}
