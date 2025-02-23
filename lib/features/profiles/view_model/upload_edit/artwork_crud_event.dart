part of 'artwork_crud_bloc.dart';

@immutable
class ArtworkCrudEvent extends Equatable {
  const ArtworkCrudEvent();

  @override
  List<Object?> get props => [];
}

class CreateArtworkEvent extends ArtworkCrudEvent {
  final String title;
  final String dimensions;
  final String price;
  final String mediumUsed;
  final String artistId;
  final String categories;
  final String? creatorsNote;
  final File images;
  final BuildContext context;

  const CreateArtworkEvent({
    required this.title,
    required this.dimensions,
    required this.price,
    required this.mediumUsed,
    required this.artistId,
    required this.categories,
    this.creatorsNote,
    required this.images,
    required this.context,
  });

  @override
  List<Object> get props => [
        title,
        dimensions,
        price,
        mediumUsed,
        artistId,
        categories,
        creatorsNote ?? '',
        images,
        context,
      ];
}

class LoadImage extends ArtworkCrudEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}
