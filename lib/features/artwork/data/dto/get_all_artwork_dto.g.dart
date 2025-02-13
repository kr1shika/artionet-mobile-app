// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_artwork_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllArtworkDTO _$GetAllArtworkDTOFromJson(Map<String, dynamic> json) =>
    GetAllArtworkDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => ArtworkApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllArtworkDTOToJson(GetAllArtworkDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
