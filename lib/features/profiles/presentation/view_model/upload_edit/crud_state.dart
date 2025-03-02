part of 'crud_bloc.dart';

@immutable
class ArtworkCrudState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const ArtworkCrudState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  const ArtworkCrudState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  // CopyWith method to update the state
  ArtworkCrudState copyWith({
    bool? isLoading,
    String? imageName,
    bool? isSuccess,
  }) {
    return ArtworkCrudState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
