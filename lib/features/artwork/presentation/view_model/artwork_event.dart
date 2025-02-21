part of 'artwork_bloc.dart';

abstract class ArtworkEvent extends Equatable {
  const ArtworkEvent();

  @override
  List<Object> get props => [];
}

class FetchAllArtworks extends ArtworkEvent {}