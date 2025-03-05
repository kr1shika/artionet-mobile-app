part of 'artist_bloc.dart';

abstract class ArtistEvent extends Equatable {
  const ArtistEvent();

  @override
  List<Object> get props => [];
}

class FetchAllArtists extends ArtistEvent {}

class FetchUserById extends ArtistEvent {
  final String userId;
  const FetchUserById(this.userId);

  @override
  List<Object> get props => [userId];
}

class FetchArtworksByUserId extends ArtistEvent {
  final String userId;
  const FetchArtworksByUserId(this.userId);

  @override
  List<Object> get props => [userId];
}
