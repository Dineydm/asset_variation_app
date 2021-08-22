import 'dart:async';

import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<ConnectivityResult> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<ConnectivityResult> get isConnected async =>
      await connectivity.checkConnectivity();
}
