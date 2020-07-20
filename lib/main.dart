import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _fcm = FirebaseMessaging();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _fcm.requestNotificationPermissions();
  _fcm.configure(
    onMessage: (message) async {
      print(message);
    }
  );

  runApp(HaweyatiBusinessApp( await SharedPreferences.getInstance()));
}

