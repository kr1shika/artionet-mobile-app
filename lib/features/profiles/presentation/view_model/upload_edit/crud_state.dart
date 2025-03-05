part of 'crud_bloc.dart';

@immutable
class ArtworkCrudState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;
  final AuthEntity? userProfile;
  final String? uploadedImageName;
  final String errorMessage;
  final AuthEntity? selectedUser;

  const ArtworkCrudState({
    required this.isLoading,
    required this.isSuccess,
    this.selectedUser,
    this.imageName,
    this.userProfile,
    this.uploadedImageName,
    required this.errorMessage,
  });

  const ArtworkCrudState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null,
        userProfile = null,
        uploadedImageName = null,
        errorMessage = '',
        selectedUser = null;

  // CopyWith method to update the state
  ArtworkCrudState copyWith({
    AuthEntity? selectedUser,
    bool? isLoading,
    String? imageName,
    bool? isSuccess,
    AuthEntity? userProfile,
    String? uploadedImageName,
    String? errorMessage,
  }) {
    return ArtworkCrudState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
      errorMessage: errorMessage ?? this.errorMessage,
      uploadedImageName: uploadedImageName ?? this.uploadedImageName,
      userProfile: userProfile ?? this.userProfile,
      selectedUser: selectedUser ?? this.selectedUser,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        errorMessage,
        imageName,
        uploadedImageName,
        userProfile,
        selectedUser,
      ];
}
