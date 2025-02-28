abstract class LightSensorRepository {
  Stream<int> getLightLevel();
  void dispose();
}