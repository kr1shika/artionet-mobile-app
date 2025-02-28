import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tryproject/core/app_theme/theme_sensor/domain/entity/theme_modes_entity.dart';
import 'package:tryproject/core/app_theme/theme_sensor/domain/usecase/theme_mode_by_sensor.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeModeBySensorUseCase _getThemeModeBySensorUseCase;
  StreamSubscription? _themeSubscription;

  ThemeBloc(this._getThemeModeBySensorUseCase)
      : super(ThemeState(isDarkMode: false)) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeState(isDarkMode: !state.isDarkMode));
    });

    on<StartAmbientTheme>((event, emit) {
      _themeSubscription =
          _getThemeModeBySensorUseCase.execute().listen((themeData) {
        add(UpdateThemeFromSensor(themeModeEntity: themeData));
      });
    });

    on<StopAmbientTheme>((event, emit) {
      _themeSubscription?.cancel();
      _themeSubscription = null;
      _getThemeModeBySensorUseCase.dispose();
    });

    on<UpdateThemeFromSensor>((event, emit) {
      emit(ThemeState(isDarkMode: event.themeModeEntity.isDarkMode));
    });
  }
}
