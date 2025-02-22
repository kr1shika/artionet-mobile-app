part of 'profile_bloc.dart';

@immutable
class ProfileState extends Equatable {
  final bool isLoading;
  final List<PurchaseEntity> purchases;
  final String errorMessage;

  const ProfileState({
    required this.isLoading,
    required this.purchases,
    required this.errorMessage,
  });

  // Initial state of the ProfileBloc
  factory ProfileState.initial() {
    return const ProfileState(
      isLoading: false,
      purchases: [],
      errorMessage: '',
    );
  }

  // CopyWith method to update the state
  ProfileState copyWith({
    bool? isLoading,
    List<PurchaseEntity>? purchases,
    String? errorMessage,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      purchases: purchases ?? this.purchases,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, purchases, errorMessage];
}
