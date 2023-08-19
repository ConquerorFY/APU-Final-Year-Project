import 'package:etaman_frontend/services/settings.dart';
import 'package:flutter/material.dart';

class SnackbarService {
  // Create Singleton instance
  SnackbarService._();
  static final SnackbarService _instance = SnackbarService._();
  factory SnackbarService() => _instance;

  Settings settings = Settings();

  static ScaffoldMessengerState? _scaffoldMessengerState;
  static void init(ScaffoldMessengerState scaffoldMessengerState) {
    _scaffoldMessengerState = scaffoldMessengerState;
  }

  void initSnackbar(String message) {
    _scaffoldMessengerState?.showSnackBar(SnackBar(
        backgroundColor: settings.snackbarBgColor,
        content: Text(message,
            style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: settings.snackbarTextColor)),
        duration: const Duration(seconds: 2) // Duration of the snackbar
        ));
  }
}
