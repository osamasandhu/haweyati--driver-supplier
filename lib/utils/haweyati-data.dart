import 'package:haweyati_supplier_driver_app/model/driver/driver_model.dart';
import 'package:haweyati_supplier_driver_app/model/supplier/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'fcm-token.dart';

class AppData {
  static Box<SupplierModel> _supplier;
  static Box<DriverModel> _driver;


  static Future init() async {

    await Hive.initFlutter();
    // My Love
    // await _clearData();
    _supplier = await Hive.openBox('supplier');
    _driver = await Hive.openBox('driver');

    print("Supplier: ${_supplier.values}");
    print("Driver: ${_driver.values}");
  }

  static void _clearData() async {
       await Hive.deleteBoxFromDisk('supplier');
       await Hive.deleteBoxFromDisk('driver');
  }


  static Future signIn (dynamic user) async {

    if(user is SupplierModel){
      await _supplier.clear();
      await _supplier.add(user);
      await user.save();
      await FCMService().updateProfileFcmToken();
    }
    else if (user is DriverModel){
      await _driver.clear();
      await _driver.add(user);
      await user.save();
      await FCMService().updateProfileFcmToken();
    }
    else {
      throw Exception("Could not determine user");
    }

  }

  static bool get isSignedIn => (_supplier.values.isNotEmpty || _driver.values.isNotEmpty);

  static bool get isDriver => _driver.values?.isNotEmpty;

  static bool get isSupplier => _supplier.values?.isNotEmpty;

  static SupplierModel get supplier => _supplier.values?.first;
  static DriverModel get driver => _driver.values?.first;

  static Future signOut() async {
    await HaweyatiService.post('auth/sign-out', {});
    await _supplier.clear();
    await _driver.clear();
  }

}