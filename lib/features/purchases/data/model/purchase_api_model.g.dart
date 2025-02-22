// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseApiModel _$PurchaseApiModelFromJson(Map<String, dynamic> json) =>
    PurchaseApiModel(
      purchaseId: json['_id'] as String?,
      art_id: json['art_id'] as String,
      buyer_id: json['buyer_id'] as String,
      address: json['address'] as String,
      status: json['status'] as String,
      otp: json['otp'] as String?,
      otp_expiration: json['otp_expiration'] == null
          ? null
          : DateTime.parse(json['otp_expiration'] as String),
      orderDate: json['orderDate'] == null
          ? null
          : DateTime.parse(json['orderDate'] as String),
      totalAmount: (json['totalAmount'] as num?)?.toInt(),
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$PurchaseApiModelToJson(PurchaseApiModel instance) =>
    <String, dynamic>{
      '_id': instance.purchaseId,
      'art_id': instance.art_id,
      'buyer_id': instance.buyer_id,
      'address': instance.address,
      'status': instance.status,
      'otp': instance.otp,
      'otp_expiration': instance.otp_expiration?.toIso8601String(),
      'orderDate': instance.orderDate?.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };
