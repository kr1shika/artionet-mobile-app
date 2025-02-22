part of 'artist_register_bloc.dart';

sealed class ArtistRegisterEvent extends Equatable {
  const ArtistRegisterEvent();

  @override
  List<Object> get props => [];
}

class NavigateScreenEvent extends ArtistRegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateScreenEvent({
    required this.context,
    required this.destination,
  });
}

class RegisterUser extends ArtistRegisterEvent {
  final BuildContext context;
  final String full_name;
  final String contact_no;
  final String email;
  final String role;
  final String password;
  final String? artistname;

  const RegisterUser(
      {required this.context,
      required this.full_name,
      required this.contact_no,
      required this.email,
      required this.role,
      required this.password,
      this.artistname});
}

class NavigateLoginScreenEvent extends ArtistRegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}
