// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_with_artwork_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseWithArtworkResponseDTO _$PurchaseWithArtworkResponseDTOFromJson(
        Map<String, dynamic> json) =>
    PurchaseWithArtworkResponseDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => PurchaseApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PurchaseWithArtworkResponseDTOToJson(
        PurchaseWithArtworkResponseDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
