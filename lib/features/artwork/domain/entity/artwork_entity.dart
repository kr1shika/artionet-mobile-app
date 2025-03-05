import 'package:equatable/equatable.dart';

class ArtworkEntity extends Equatable {
  final String? artworkId;
  final String title;
  final String dimensions;
  final String price;
  final String medium_used;
  final String? images;
  final String? archive;
  final String? artistId;
  final String categories;
  final String? creatorsNote;
  final bool? isLiked;

  const ArtworkEntity({
    this.artworkId,
    this.artistId,
    required this.title,
    required this.dimensions,
    this.images,
    this.isLiked,
    this.archive,
    required this.price,
    required this.medium_used,
    required this.categories,
    this.creatorsNote,
  });

  const ArtworkEntity.empty()
      : artworkId = '_empty.artworkId',
        artistId = '_empty.artistId',
        title = '_empty.title',
        dimensions = '_empty.dimensions',
        images = '_empty.images',
        archive = '_empty.archive',
        price = '_empty.price',
        medium_used = '_empty.medium_used',
        categories = '_empty.categories',
        creatorsNote = '_empy',
        isLiked = null;

  ArtworkEntity copyWith({
    String? artworkId,
    String? title,
    String? dimensions,
    String? price,
    String? medium_used,
    String? images,
    String? archive,
    bool? isLiked,
    String? artistId,
    String? categories,
    String? creatorsNote,
  }) {
    return ArtworkEntity(
      artworkId: artworkId ?? this.artworkId,
      title: title ?? this.title,
      dimensions: dimensions ?? this.dimensions,
      price: price ?? this.price,
      medium_used: medium_used ?? this.medium_used,
      images: images ?? this.images,
      archive: archive ?? this.archive,
      isLiked: isLiked ?? this.isLiked,
      artistId: artistId ?? this.artistId,
      categories: categories ?? this.categories,
      creatorsNote: creatorsNote ?? this.creatorsNote,
    );
  }

  @override
  List<Object?> get props => [
        artworkId,
        artistId,
        title,
        dimensions,
        images,
        archive,
        price,
        medium_used,
        categories,
        creatorsNote,
        isLiked,
      ];
}
