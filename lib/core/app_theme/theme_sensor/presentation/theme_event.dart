part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class StartAmbientTheme extends ThemeEvent {}

class StopAmbientTheme extends ThemeEvent {}

class UpdateThemeFromSensor extends ThemeEvent {
  final ThemeModeEntity themeModeEntity;

  UpdateThemeFromSensor({required this.themeModeEntity});
}