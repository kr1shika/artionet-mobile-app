// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_artwork_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveArtworkApiModel _$SaveArtworkApiModelFromJson(Map<String, dynamic> json) =>
    SaveArtworkApiModel(
      savedId: json['_id'] as String?,
      art_id: json['art_id'] as String,
      buyer_id: json['buyer_id'] as String,
      title: json['title'] as String?,
      imageUrl: json['imageUrl'] as String?,
      status: json['status'] as String,
    );

Map<String, dynamic> _$SaveArtworkApiModelToJson(
        SaveArtworkApiModel instance) =>
    <String, dynamic>{
      '_id': instance.savedId,
      'art_id': instance.art_id,
      'buyer_id': instance.buyer_id,
      'status': instance.status,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
    };
