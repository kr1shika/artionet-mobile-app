part of 'customer_profile_bloc.dart';

abstract class CustomerProfileState extends Equatable {
  const CustomerProfileState();

  @override
  List<Object> get props => [];
}

class CustomerProfileInitial extends CustomerProfileState {}

class CustomerProfileLoading extends CustomerProfileState {}

class CustomerProfileLoaded extends CustomerProfileState {
  final AuthEntity user;

  const CustomerProfileLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class CustomerProfileError extends CustomerProfileState {
  final String message;

  const CustomerProfileError(this.message);

  @override
  List<Object> get props => [message];
}
