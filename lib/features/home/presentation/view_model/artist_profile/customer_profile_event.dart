part of 'customer_profile_bloc.dart';

abstract class CustomerProfileEvent extends Equatable {
  const CustomerProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchCustomerProfileEvent extends CustomerProfileEvent {}
