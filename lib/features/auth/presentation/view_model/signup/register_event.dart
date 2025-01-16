part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class LoadCoursesAndBatches extends RegisterEvent {}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String full_name;
  final String contact_no;
  final String email;

  final String role;
  final String password;

  const RegisterUser({
    required this.context,
    required this.full_name,
    required this.contact_no,
    required this.email,
    required this.role,
    required this.password,
  });
}

class NavigateLoginScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}
