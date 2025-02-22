part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class NavigateScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateScreenEvent({
    required this.context,
    required this.destination,
  });
}

// for image-upload
class LoadImage extends RegisterEvent {
  final File file;

  const LoadImage({
    required this.file,
  });
}

class RegisterUser extends RegisterEvent {
  final BuildContext context;
  final String full_name;
  final String contact_no;
  final String email;

  final String role;
  final String password;
  final String? profilepic;

  const RegisterUser(
      {required this.context,
      required this.full_name,
      required this.contact_no,
      required this.email,
      required this.role,
      required this.password,
      this.profilepic});
}

class NavigateLoginScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}
