import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/src/models/image_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/vehicle_model.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/app.dart';

import 'src/models/users/driver_model.dart';
import 'src/models/users/supplier_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await AppData.initiate();

  FirebaseMessaging().subscribeToTopic('news');

  runApp(HaweyatiBusinessApp());
}
