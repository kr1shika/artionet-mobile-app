part of 'artist_login_bloc.dart';

sealed class ArtistLoginEvent extends Equatable {
  const ArtistLoginEvent();

  @override
  List<Object> get props => [];
}

class NavigateRegisterScreenEvent extends ArtistLoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateRegisterScreenEvent({
    required this.context,
    required this.destination,
  });
}

class NavigateHomeScreenEvent extends ArtistLoginEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateHomeScreenEvent({
    required this.context,
    required this.destination,
  });
}

class LoginUserEvent extends ArtistLoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  const LoginUserEvent({
    required this.context,
    required this.email,
    required this.password,
  });
}
