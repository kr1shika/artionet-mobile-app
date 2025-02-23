part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final List<PurchaseEntity> purchases;
  final String errorMessage;

  const ProfileState({
    required this.isLoading,
    required this.purchases,
    required this.errorMessage,
    required this.isSuccess,
  });

  // Initial state of the ProfileBloc
  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      purchases: [],
      errorMessage: '',
      isSuccess: false,
    );
  }

  // CopyWith method to update the state
  ProfileState copyWith({
    bool? isLoading,
    List<PurchaseEntity>? purchases,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      purchases: purchases ?? this.purchases,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, purchases, errorMessage, isSuccess];
}
