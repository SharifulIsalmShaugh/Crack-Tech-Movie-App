import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class ConnectionManagerController extends GetxController {
  // //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  var connectionType = 2.obs;
  var connected = true.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  Future<bool> connectivityChecker() async {
    if (kDebugMode) {
      print("Checking internet...");
    }
    try {
      final result = await InternetAddress.lookup("https://www.google.com");
      final result2 = await InternetAddress.lookup("https://www.facebook.com");
      final result3 = await InternetAddress.lookup("https://www.microsoft.com");
      if (kDebugMode) {
        print("Result: $result");
      }
      if (kDebugMode) {
        print("Address: ${result[0].rawAddress}");
      }
      if ((result.isNotEmpty && result[0].rawAddress.isNotEmpty) ||
          (result2.isNotEmpty && result2[0].rawAddress.isNotEmpty) ||
          (result3.isNotEmpty && result3[0].rawAddress.isNotEmpty)) {
        if (kDebugMode) {
          print('connected..');
        }
        connected.value = true;
      } else {
        if (kDebugMode) {
          print("not connected from else..");
        }
        connected.value = false;
      }
    } on SocketException catch (_) {
      if (kDebugMode) {
        print('SocketException not connected...');
      }
      connected.value = false;
    }
    return connected.value;
  }

  _updateState(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = 1;
        //connectivityChecker();
        break;
      case ConnectivityResult.mobile:
        connectionType.value = 2;
        //connectivityChecker();
        break;
      case ConnectivityResult.none:
        connectionType.value = 0;
        break;
      default:
        Get.snackbar(
            'Internet',
            'No Internet Connection.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white
        );
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}