part of 'artwork_crud_bloc.dart';

@immutable
class ArtworkCrudEvent extends Equatable {
  const ArtworkCrudEvent();

  @override
  List<Object?> get props => [];
}

class UpdateArtworkEvent extends ArtworkCrudEvent {
  final String artworkId;
  final String title;
  final String dimensions;
  final String price;
  final String mediumUsed;
  final String categories;
  final String? creatorsNote;
  final String? images;
  final BuildContext context;

  const UpdateArtworkEvent({
    required this.artworkId,
    required this.title,
    required this.dimensions,
    required this.price,
    required this.mediumUsed,
    required this.categories,
    this.creatorsNote,
    this.images,
    required this.context,
  });

  @override
  List<Object?> get props => [
        artworkId,
        title,
        dimensions,
        price,
        mediumUsed,
        categories,
        creatorsNote,
        images,
        context,
      ];
}

class CreateArtworkEvent extends ArtworkCrudEvent {
  final String title;
  final String dimensions;
  final String price;
  final String mediumUsed;
  final String? artistId;
  final String categories;
  final String? creatorsNote;
  final String? images;
  final BuildContext context;

  const CreateArtworkEvent({
    required this.title,
    required this.dimensions,
    required this.price,
    required this.mediumUsed,
    this.artistId,
    required this.categories,
    this.creatorsNote,
    this.images,
    required this.context,
  });

  @override
  List<Object> get props => [
        title,
        dimensions,
        price,
        mediumUsed,
        categories,
        creatorsNote ?? '',
        // images,
        context,
      ];
}

class LoadImage extends ArtworkCrudEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}
