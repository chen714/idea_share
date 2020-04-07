import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class LocalAuthService {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> _checkBiometric() async {
    bool checkBiometric = false;
    try {
      checkBiometric = await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      showToast();
      return false;
    }
    return checkBiometric;
  }

  Future<bool> _checkFingerPrint() async {
    if (await _checkBiometric()) {
      List<BiometricType> listofBiometric;
      try {
        listofBiometric = await _localAuthentication.getAvailableBiometrics();
      } on PlatformException catch (e) {
        showToast();
        return false;
      }
      if (listofBiometric.contains(BiometricType.fingerprint)) {
        return true;
      } else {
        showToast();
        return false;
      }
    } else {
      showToast();
      return false;
    }
  }

  Future<bool> _authenticate() async {
    bool isAuthorized = false;
    isAuthorized = await _localAuthentication.authenticateWithBiometrics(
      localizedReason: "Please authenticate to login",
      useErrorDialogs: true,
      stickyAuth: true,
    );
    return isAuthorized;
  }

  Future<bool> authorizeNow() async {
    bool isAuth = false;
    if (await _checkFingerPrint()) {
      try {
        isAuth = await _authenticate();
      } on PlatformException catch (e) {
        showToast();
        return false;
      }
      return isAuth;
    } else {
      showToast();
      return false;
    }
  }

  void showToast() {
    Fluttertoast.showToast(
        msg:
            "Opps.. Something went wrong. \n Biometrics required to use this application.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
