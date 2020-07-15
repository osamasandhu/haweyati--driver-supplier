import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(HaweyatiBusinessApp( await SharedPreferences.getInstance()));
}