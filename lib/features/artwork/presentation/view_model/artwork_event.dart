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

class NavigateToPurchase extends ArtworkEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateToPurchase({
    required this.context,
    required this.destination,
  });
}
