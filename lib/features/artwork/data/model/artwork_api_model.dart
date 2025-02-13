import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';

part 'artwork_api_model.g.dart';

@JsonSerializable()
class ArtworkApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? id;
  final String title;
  final String dimensions;
  final String price;
  final String medium_used;
  final String? images;
  final String? archive;
  final String? artistId;
  final String categories;

  const ArtworkApiModel(
      {this.id,
      required this.artistId,
      required this.title,
      required this.dimensions,
      required this.images,
      required this.archive,
      required this.price,
      required this.medium_used,
      required this.categories});

  factory ArtworkApiModel.fromJson(Map<String, dynamic> json) =>
      _$ArtworkApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtworkApiModelToJson(this);

  ArtworkEntity toEntity() {
    return ArtworkEntity(
        artworkId: id,
        title: title,
        dimensions: dimensions,
        price: price,
        medium_used: medium_used,
        categories: categories,
        artistId: artistId,
        images: images);
  }

  factory ArtworkApiModel.fromEntity(ArtworkEntity entity) {
    return ArtworkApiModel(
      title: entity.title,
      dimensions: entity.dimensions,
      price: entity.price,
      medium_used: entity.medium_used,
      categories: entity.categories,
      artistId: entity.artistId,
      images: entity.images,
      archive: entity.archive,
    );
  }

  static List<ArtworkEntity> toEntityList(List<ArtworkApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dimensions,
        price,
        medium_used,
        categories,
        artistId,
        images,
        archive
      ];
}
