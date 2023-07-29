import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mealorder/core/enums/connectivity_status.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectivityStatusController =
  StreamController<ConnectivityStatus>();

  ConnectivityService() {
    final Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((event) {
      connectivityStatusController.add(getStatus(event));
    });
  }

  ConnectivityStatus getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.wifi:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.ethernet:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.none:
        return ConnectivityStatus.OFFLINE;
      case ConnectivityResult.vpn:
        return ConnectivityStatus.ONLINE;

    }
  }
}