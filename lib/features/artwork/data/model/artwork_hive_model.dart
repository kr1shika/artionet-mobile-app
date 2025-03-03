import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tryproject/features/artwork/domain/entity/artwork_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/constants/hive_table_constant.dart';

part 'artwork_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.artworkTableId)
class ArtworkHiveModel extends Equatable {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? title;
  @HiveField(2)
  final String dimensions;
  @HiveField(3)
  final String price;
  @HiveField(4)
  final String medium_used;
  @HiveField(5)
  late String? images;
  @HiveField(6)
  final String? archive;
  @HiveField(7)
  final bool? isLiked;
  @HiveField(8)
  final String? artistId;
  @HiveField(9)
  final String categories;
  @HiveField(10)
  final String? creatorsNote;

  ArtworkHiveModel({
    String? id,
    required this.title,
    required this.dimensions,
    required this.price,
    required this.medium_used,
    this.images,
    required this.archive,
    this.isLiked,
    required this.artistId,
    required this.categories,
    this.creatorsNote,
  }) : id = id ?? const Uuid().v4();

  ArtworkHiveModel.initial()
      : id = '',
        title = '',
        dimensions = '',
        price = '',
        medium_used = '',
        images = '',
        archive = '',
        isLiked = false,
        artistId = '',
        categories = '',
        creatorsNote = '';

  factory ArtworkHiveModel.fromEntity(ArtworkEntity entity) {
    return ArtworkHiveModel(
      id: entity.artworkId,
      title: entity.title,
      dimensions: entity.dimensions,
      price: entity.price,
      medium_used: entity.medium_used,
      images: entity.images,
      archive: entity.archive,
      isLiked: entity.isLiked,
      artistId: entity.artistId,
      categories: entity.categories,
      creatorsNote: entity.creatorsNote,
    );
  }

  ArtworkEntity toEntity() {
    return ArtworkEntity(
        title: title ?? '',
        artworkId: id,
        dimensions: dimensions,
        price: price,
        medium_used: medium_used,
        images: images ?? '',
        archive: archive,
        isLiked: isLiked,
        artistId: artistId,
        categories: categories,
        creatorsNote: creatorsNote);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        title,
        dimensions,
        price,
        medium_used,
        images,
        archive,
        isLiked,
        artistId,
        categories,
        creatorsNote
      ];
}
