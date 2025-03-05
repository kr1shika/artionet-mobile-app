// artwork_state.dart
part of 'artwork_bloc.dart';

class ArtworkState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<ArtworkEntity> artworks;
  final ArtworkEntity? selectedArtwork;
  final Map<String, bool> likedStatuses;
  final AuthEntity? selectedUser;

  const ArtworkState({
    required this.isLoading,
    this.errorMessage,
    required this.artworks,
    this.selectedArtwork,
    required this.likedStatuses,
    this.selectedUser,
  });

  factory ArtworkState.initial() {
    return const ArtworkState(
      isLoading: false,
      errorMessage: null,
      artworks: [],
      selectedArtwork: null,
      likedStatuses: {},
      selectedUser: null,
    );
  }

  ArtworkState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<ArtworkEntity>? artworks,
    ArtworkEntity? selectedArtwork,
    Map<String, bool>? likedStatuses,
    AuthEntity? selectedUser,
  }) {
    return ArtworkState(
      isLoading: isLoading ?? this.isLoading,
      likedStatuses: likedStatuses ?? this.likedStatuses,
      errorMessage: errorMessage ?? this.errorMessage,
      artworks: artworks ?? this.artworks,
      selectedArtwork: selectedArtwork ?? this.selectedArtwork,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        artworks,
        selectedArtwork,
        likedStatuses,
        selectedUser
      ];
}
