// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_with_artwork_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseWithArtworkDTO _$PurchaseWithArtworkDTOFromJson(
        Map<String, dynamic> json) =>
    PurchaseWithArtworkDTO(
      purchaseId: json['purchaseId'] as String,
      artId: json['artId'] as String,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String,
      orderDate: DateTime.parse(json['orderDate'] as String),
      totalAmount: (json['totalAmount'] as num).toInt(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$PurchaseWithArtworkDTOToJson(
        PurchaseWithArtworkDTO instance) =>
    <String, dynamic>{
      'purchaseId': instance.purchaseId,
      'artId': instance.artId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'status': instance.status,
      'orderDate': instance.orderDate.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'address': instance.address,
    };
