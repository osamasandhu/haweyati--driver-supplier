import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/model/common/image_model.dart';
import 'package:haweyati_supplier_driver_app/model/common/location_model.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-data.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/app.dart';

import 'model/common/profile_model.dart';
import 'model/driver/driver_model.dart';
import 'model/driver/vehicle_model.dart';
import 'model/supplier/supplier_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging().subscribeToTopic('news');

  Hive.registerAdapter<Vehicle>(VehicleAdapter());
  Hive.registerAdapter<ImageModel>(ImageModelAdapter());
  Hive.registerAdapter<DriverModel>(DriverModelAdapter());
  Hive.registerAdapter<PersonModel>(PersonModelAdapter());
  Hive.registerAdapter<SupplierModel>(SupplierModelAdapter());
  Hive.registerAdapter<HiveLocation>(HiveLocationAdapter());

  await AppData.init();

  String getInitialRoute(){
    if(AppData.isSignedIn){
      if(AppData.isSupplier){
        return AppData.supplier.status == 'Active' ? '/supplier-home-page' : '/waiting-approval';
      }
      else if(AppData.isDriver){
        return AppData.driver.status == 'Active' ? '/driver-home-page' : '/waiting-approval';
      }
      else {
        throw Exception("Could not determine user type");
      }
    } else {
      return '/';
    }
  }

  runApp(HaweyatiBusinessApp(getInitialRoute()));

}
