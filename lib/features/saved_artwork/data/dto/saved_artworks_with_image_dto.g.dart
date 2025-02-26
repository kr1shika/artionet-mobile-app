// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_artworks_with_image_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

getUserCollectionDTO _$getUserCollectionDTOFromJson(
        Map<String, dynamic> json) =>
    getUserCollectionDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => SaveArtworkApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$getUserCollectionDTOToJson(
        getUserCollectionDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
