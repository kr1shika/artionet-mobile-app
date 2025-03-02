part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<PurchaseEntity> purchases;
  final List<SaveArtworkEntity> collection;

  final List<ArtworkEntity> artworks;
  final ArtworkEntity? selectedArtwork;
  final AuthEntity? selectedUser;
  final AuthEntity? userProfile;

  final String errorMessage;
  final List<NotificationEntity> notifications;
  final String? uploadedImageName;

  const ProfileState({
    this.userProfile,
    this.selectedUser,
    required this.isLoading,
    required this.purchases,
    required this.errorMessage,
    required this.isSuccess,
    required this.artworks,
    this.selectedArtwork,
    required this.collection,
    required this.notifications,
    this.uploadedImageName,
  });

  // Initial state of the ProfileBloc
  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      purchases: [],
      errorMessage: '',
      isSuccess: false,
      artworks: [],
      selectedArtwork: null,
      selectedUser: null,
      notifications: [],
      collection: [],
      userProfile: null,
      uploadedImageName: null,
    );
  }

  ProfileState copyWith({
    bool? isLoading,
    List<PurchaseEntity>? purchases,
    List<ArtworkEntity>? artworks,
    AuthEntity? selectedUser,
    String? errorMessage,
    bool? isSuccess,
    AuthEntity? userProfile,
    ArtworkEntity? selectedArtwork,
    List<SaveArtworkEntity>? collection,
    List<NotificationEntity>? notifications,
    String? uploadedImageName,
  }) {
    return ProfileState(
      uploadedImageName: uploadedImageName ?? this.uploadedImageName,
      isLoading: isLoading ?? this.isLoading,
      purchases: purchases ?? this.purchases,
      artworks: artworks ?? this.artworks,
      userProfile: userProfile ?? this.userProfile,
      selectedUser: selectedUser ?? this.selectedUser,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedArtwork: selectedArtwork ?? this.selectedArtwork,
      collection: collection ?? this.collection,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object?> get props => [
        userProfile,
        isLoading,
        purchases,
        errorMessage,
        isSuccess,
        artworks,
        selectedArtwork,
        collection,
        notifications,
        selectedUser,
        uploadedImageName
      ];
}
