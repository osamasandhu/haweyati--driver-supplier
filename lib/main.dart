import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await AppData.initiate();

  FirebaseMessaging().subscribeToTopic('news');

  runApp(HaweyatiBusinessApp());
}
