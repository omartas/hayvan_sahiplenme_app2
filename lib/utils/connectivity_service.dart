import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Stream<ConnectivityResult> döndüren fonksiyon
  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<bool> checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}