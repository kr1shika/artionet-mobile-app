part of 'artist_bloc.dart';

class ArtistState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final List<AuthEntity> artists;

  const ArtistState({
    required this.isLoading,
    this.errorMessage,
    required this.artists,
  });

  factory ArtistState.initial() {
    return const ArtistState(
      isLoading: false,
      errorMessage: null,
      artists: [],
    );
  }

  ArtistState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<AuthEntity>? artists,
  }) {
    return ArtistState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      artists: artists ?? this.artists,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, artists];
}