// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtworkApiModel _$ArtworkApiModelFromJson(Map<String, dynamic> json) =>
    ArtworkApiModel(
      id: json['_id'] as String?,
      artistId: json['artistId'] as String?,
      title: json['title'] as String,
      dimensions: json['dimensions'] as String,
      images: json['images'] as String?,
      archive: json['archive'] as String?,
      price: json['price'] as String,
      medium_used: json['medium_used'] as String,
      creatorsNote: json['creatorsNote'] as String?,
      isLiked: json['isLiked'] as bool?,
      categories: json['categories'] as String,
    );

Map<String, dynamic> _$ArtworkApiModelToJson(ArtworkApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'dimensions': instance.dimensions,
      'price': instance.price,
      'medium_used': instance.medium_used,
      'images': instance.images,
      'archive': instance.archive,
      'isLiked': instance.isLiked,
      'artistId': instance.artistId,
      'categories': instance.categories,
      'creatorsNote': instance.creatorsNote,
    };
