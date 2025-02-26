part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<PurchaseEntity> purchases;
  final List<SaveArtworkEntity> collection;

  final List<ArtworkEntity> artworks;
  final ArtworkEntity? selectedArtwork;

  final String errorMessage;
  

  const ProfileState(
      {required this.isLoading,
      required this.purchases,
      required this.errorMessage,
      required this.isSuccess,
      required this.artworks,
      this.selectedArtwork,
      required this.collection});

  // Initial state of the ProfileBloc
  factory ProfileState.initial() {
    return const ProfileState(
        isLoading: false,
        purchases: [],
        errorMessage: '',
        isSuccess: false,
        artworks: [],
        selectedArtwork: null,
        collection: []);
  }

  // CopyWith method to update the state
  ProfileState copyWith({
    bool? isLoading,
    List<PurchaseEntity>? purchases,
    List<ArtworkEntity>? artworks,
    String? errorMessage,
    bool? isSuccess,
    ArtworkEntity? selectedArtwork,
    List<SaveArtworkEntity>? collection,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      purchases: purchases ?? this.purchases,
      artworks: artworks ?? this.artworks,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedArtwork: selectedArtwork ?? this.selectedArtwork,
      collection: collection ?? this.collection,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        purchases,
        errorMessage,
        isSuccess,
        artworks,
        selectedArtwork,
        collection
      ];
}
