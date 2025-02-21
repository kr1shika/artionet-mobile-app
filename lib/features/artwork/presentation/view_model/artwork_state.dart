// artwork_state.dart
part of 'artwork_bloc.dart';

class ArtworkState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<ArtworkEntity> artworks;
  final ArtworkEntity? selectedArtwork;

  const ArtworkState({
    required this.isLoading,
    this.errorMessage,
    required this.artworks,
    this.selectedArtwork,
  });

  factory ArtworkState.initial() {
    return const ArtworkState(
      isLoading: false,
      errorMessage: null,
      artworks: [],
      selectedArtwork: null,
    );
  }

  ArtworkState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ArtworkEntity>? artworks,
    ArtworkEntity? selectedArtwork,
  }) {
    return ArtworkState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      artworks: artworks ?? this.artworks,
      selectedArtwork: selectedArtwork ?? this.selectedArtwork,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, errorMessage, artworks, selectedArtwork];
}
