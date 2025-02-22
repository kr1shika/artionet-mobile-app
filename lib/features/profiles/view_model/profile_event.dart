part of 'profile_bloc.dart';

@immutable
class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchPurchasesByUserId extends ProfileEvent {
  final String userId;

  const FetchPurchasesByUserId({required this.userId});

  @override
  List<Object?> get props => [userId];
}
