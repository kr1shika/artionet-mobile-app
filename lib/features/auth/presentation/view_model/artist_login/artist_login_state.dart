part of 'artist_login_bloc.dart';

class ArtistLoginState {
  final bool isLoading;
  final bool isSuccess;

  ArtistLoginState({
    required this.isLoading,
    required this.isSuccess,
  });

  ArtistLoginState.initial()
      : isLoading = false,
        isSuccess = false;

  ArtistLoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ArtistLoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
