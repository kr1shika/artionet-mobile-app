part of 'artist_bloc.dart';

class ArtistState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<AuthEntity> artists;
  final AuthEntity? selectedUser;
  final List<ArtworkEntity> artworks;

  const ArtistState({
    required this.isLoading,
    this.errorMessage,
    required this.artists,
    this.selectedUser,
    required this.artworks,
  });

  factory ArtistState.initial() {
    return const ArtistState(
      isLoading: false,
      errorMessage: null,
      artists: [],
      selectedUser: null,
      artworks: [],
    );
  }

  ArtistState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<AuthEntity>? artists,
    AuthEntity? selectedUser,
    List<ArtworkEntity>? artworks,
  }) {
    return ArtistState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      artists: artists ?? this.artists,
      selectedUser: selectedUser ?? this.selectedUser,
      artworks: artworks ?? this.artworks,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, errorMessage, artists, selectedUser, artworks];
}
