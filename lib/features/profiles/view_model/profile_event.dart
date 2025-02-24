part of 'profile_bloc.dart';

@immutable
class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class CreateArtworkEvent extends ProfileEvent {
  final String title;
  final String dimensions;
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
    this.creatorsNote,
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
        creatorsNote ?? '',
        imageFile,
        context,
      ];
}

class FetchPurchasesByUserId extends ProfileEvent {
  final String userId;

  const FetchPurchasesByUserId({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class FetchArtworkByUserID extends ProfileEvent {
  final String userId;

  const FetchArtworkByUserID({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class NavigateToUpload extends ProfileEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToUpload({
    required this.context,
    required this.destination,
  });
}
