part of 'artwork_bloc.dart';

class ArtworkState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<ArtworkEntity> artworks;

  const ArtworkState({
    required this.isLoading,
    this.errorMessage,
    required this.artworks,
  });

  factory ArtworkState.initial() {
    return const ArtworkState(
      isLoading: false,
      errorMessage: null,
      artworks: [], // Ensure artworks is never null
    );
  }

  ArtworkState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ArtworkEntity>? artworks,
  }) {
    return ArtworkState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      artworks: artworks ?? this.artworks, // Default to existing list
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, artworks];
}
