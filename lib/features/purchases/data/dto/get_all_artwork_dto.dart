import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/artwork/data/model/artwork_api_model.dart';

part 'get_all_artwork_dto.g.dart';

@JsonSerializable()
class GetAllArtworkDTO {
  final bool success;
  final int count;
  final List<ArtworkApiModel> data;

  GetAllArtworkDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllArtworkDTOToJson(this);

  factory GetAllArtworkDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllArtworkDTOFromJson(json);
}
