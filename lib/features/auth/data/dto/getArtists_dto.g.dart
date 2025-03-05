// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getArtists_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllArtistsDTO _$GetAllArtistsDTOFromJson(Map<String, dynamic> json) =>
    GetAllArtistsDTO(
      success: json['success'] as bool,
      count: (json['count'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllArtistsDTOToJson(GetAllArtistsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
