import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/saved_artwork/data/model/save_artwork_api_model.dart';

part 'saved_artworks_with_image_dto.g.dart';

@JsonSerializable()
class getUserCollectionDTO {
  final bool success;
  final int count;
  final List<SaveArtworkApiModel> data;

  getUserCollectionDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  factory getUserCollectionDTO.fromJson(Map<String, dynamic> json) =>
      _$getUserCollectionDTOFromJson(json);

  Map<String, dynamic> toJson() => _$getUserCollectionDTOToJson(this);
}
