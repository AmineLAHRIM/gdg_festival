import 'package:connectivity/connectivity.dart';
import 'package:injectable/injectable.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile;
  }
}
