part of 'artwork_bloc.dart';

abstract class ArtworkEvent extends Equatable {
  const ArtworkEvent();

  @override
  List<Object> get props => [];
}

class FetchAllArtworks extends ArtworkEvent {}

class FetchArtworkById extends ArtworkEvent {
  final String id;

  const FetchArtworkById(this.id);

  @override
  List<Object> get props => [id];
}

class SaveArtworkEvent extends ArtworkEvent {
  final String artId;
  final String buyerId;

  const SaveArtworkEvent({required this.artId, required this.buyerId});

  @override
  List<Object> get props => [artId, buyerId];
}

class RemoveSavedArtworkEvent extends ArtworkEvent {
  final String artId;
  final String buyerId;

  const RemoveSavedArtworkEvent({required this.artId, required this.buyerId});

  @override
  List<Object> get props => [artId, buyerId];
}

class CheckArtworkStatusEvent extends ArtworkEvent {
  final String artId;
  final String buyerId;

  const CheckArtworkStatusEvent({required this.artId, required this.buyerId});

  @override
  List<Object> get props => [artId, buyerId];
}

class NavigateToPurchase extends ArtworkEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToPurchase({
    required this.context,
    required this.destination,
  });
}

class NavigateToArtists extends ArtworkEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToArtists({
    required this.context,
    required this.destination,
  });
}

class SearchArtworksEvent extends ArtworkEvent {
  final String query;
  const SearchArtworksEvent(this.query);
  @override
  List<Object> get props => [query];
}

class FetchUserById extends ArtworkEvent {
  final String userId;

  const FetchUserById(this.userId);

  @override
  List<Object> get props => [userId];
}

class UpdateArtworkEvent extends ArtworkEvent {
  final String artId;
  final Map<String, dynamic> updatedData;

  const UpdateArtworkEvent({required this.artId, required this.updatedData});

  @override
  List<Object> get props => [artId, updatedData];
}
