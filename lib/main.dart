import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/app.dart';
import 'src/services/hyper-track_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppData.initiate();
  if(AppData.isDriver && !HyperTrackService.isInitialised) await HyperTrackService.initializeSdk();

  FirebaseMessaging().subscribeToTopic('news');

  runApp(HaweyatiBusinessApp());
}
