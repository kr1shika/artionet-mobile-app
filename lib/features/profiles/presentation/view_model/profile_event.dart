part of 'profile_bloc.dart';

@immutable
class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class CreateArtworkEvent extends ProfileEvent {
  final String title;
  final String artworkId;
  final String dimensions;
  final String archive;
  final String price;
  final String mediumUsed;
  final String artistId;
  final String categories;
  final String? creatorsNote;
  final File imageFile;
  final BuildContext context;

  const CreateArtworkEvent({
    required this.title,
    required this.dimensions,
    required this.price,
    required this.mediumUsed,
    required this.artistId,
    required this.categories,
    required this.artworkId,
    this.creatorsNote,
    required this.archive,
    required this.imageFile,
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
        artworkId,
        creatorsNote ?? '',
        imageFile,
        context,
        archive
      ];
}

class FetchPurchasesByUserId extends ProfileEvent {
  final String userId;

  const FetchPurchasesByUserId({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class GetCollection extends ProfileEvent {
  final String buyerId;
  const GetCollection({required this.buyerId});

  @override
  List<Object?> get props => [buyerId];
}

class FetchArtworkByUserID extends ProfileEvent {
  final String userId;

  const FetchArtworkByUserID({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class FetchArtworkById extends ProfileEvent {
  final String id;

  const FetchArtworkById(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteArtworkById extends ProfileEvent {
  final String artworkId;

  const DeleteArtworkById(this.artworkId);

  @override
  List<Object> get props => [artworkId];
}

class NavigateToUpload extends ProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToUpload({
    required this.context,
    required this.destination,
  });
}

class NavigateToEdit extends ProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToEdit({
    required this.context,
    required this.destination,
  });
}

class NavigateToDetailView extends ProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToDetailView({
    required this.context,
    required this.destination,
  });
}

class UpdateArtworkEvent extends ProfileEvent {
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

class FetchNotificationsByUserId extends ProfileEvent {
  final String userId;

  const FetchNotificationsByUserId({required this.userId});

  @override
  List<Object?> get props => [userId];
}