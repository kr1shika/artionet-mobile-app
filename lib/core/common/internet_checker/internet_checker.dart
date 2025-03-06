import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> monitorConnection() =>
      _connectivity.onConnectivityChanged;

  Future<bool> isConnected() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult.isNotEmpty &&
        connectivityResult.every((result) => result != ConnectivityResult.none);
  }
}
