import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/auth/data/model/auth_api_model.dart';

part 'getArtists_dto.g.dart';

@JsonSerializable()
class GetAllArtistsDTO {
  final bool success;
  final int count;
  final List<AuthApiModel> data;

  GetAllArtistsDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllArtistsDTOToJson(this);

  factory GetAllArtistsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllArtistsDTOFromJson(json);
}
