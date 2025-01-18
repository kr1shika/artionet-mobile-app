part of 'artist_register_bloc.dart';

class ArtistRegisterState {
  final bool isLoading;
  final bool isSuccess;

  ArtistRegisterState({
    required this.isLoading,
    required this.isSuccess,
  });

  ArtistRegisterState.initial()
      : isLoading = false,
        isSuccess = false;

  ArtistRegisterState copyWith({
    bool? isLoading,
    bool? isSuccess,
  }) {
    return ArtistRegisterState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
