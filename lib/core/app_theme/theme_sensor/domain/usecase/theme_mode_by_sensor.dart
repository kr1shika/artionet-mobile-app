
import 'package:tryproject/core/app_theme/theme_sensor/domain/entity/theme_modes_entity.dart';
import 'package:tryproject/core/app_theme/theme_sensor/domain/repository/lightsensor_repository.dart';

class GetThemeModeBySensorUseCase {
  final LightSensorRepository repository;

  GetThemeModeBySensorUseCase(this.repository);

  Stream<ThemeModeEntity> execute() async* {
    const threshold = 50;

    await for (final lux in repository.getLightLevel()) {
      yield ThemeModeEntity(lux < threshold);
    }
  }

  void dispose() {
    repository.dispose();
  }
}
