import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/models/image_model.dart';
import 'package:haweyati_client_data_models/models/order/vehicle-type.dart';
import 'package:haweyati_supplier_driver_app/model/models/images_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/fcm-token.dart';
import 'models/image_model.dart';
import 'models/profile_model.dart';
import 'models/users/vehicle_model.dart';
import 'package:haweyati_client_data_models/models/image_model.dart' as img;

abstract class AppData {
  /// Localization Specific Data
  ValueNotifier<Locale> currentLocale;
  set locale(Locale locale);


  static Box<Driver> _driver;
  static Box<SupplierModel> _supplier;

  factory AppData.instance() {
    if (_initiated) {
      return _instance;
    } else {
      throw Error();
    }
  }


  /// Address specific Data
  String get city;
  String get address;
  LatLng get coordinates;

  Location get location;
  set location(Location details);


  /// These controls determine weather the
  /// app has been launched before or not.
  Future<void> burnFuse();
  Future<bool> get isFuseBurnt;


  static bool _initiated;
  static _AppDataImpl _instance;

  static Future initiate() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Profile>(ProfileAdapter());
    Hive.registerAdapter<Location>(LocationAdapter());
    Hive.registerAdapter<Images>(ImagesAdapter());
    Hive.registerAdapter<img.ImageModel>(img.ImageModelAdapter());
    Hive.registerAdapter<SupplierModel>(SupplierModelAdapter());
    Hive.registerAdapter<Driver>(DriverAdapter());
    Hive.registerAdapter<Vehicle>(VehicleAdapter());
    Hive.registerAdapter<VehicleType>(VehicleTypeAdapter());

    _supplier = await Hive.openBox('supplier');
    _driver = await Hive.openBox('driver');

    // _clearData();

    _initiated = true;
    _instance = _AppDataImpl();
    await _instance._loadCache();

    // print("Supplier: ${(AppData.isSignedIn && AppData.isSupplier)
    //     ? _supplier?.values?.first?.toJson() : _supplier.values}");
    // print("Driver: ${(AppData.isSignedIn && AppData.isDriver)
    //     ? _driver?.values?.first?.serialize() : _driver.values}");
  }

  static void _clearData() async {
     await Hive.box('supplier').clear();
     await Hive.box('driver').clear();
  }

  static Future signIn (dynamic user) async {
    if (user is SupplierModel) {
      await _supplier.clear();
      await _supplier.add(user);
      await user.save();
      await FCMService().updateProfileFcmToken();
    } else if (user is Driver) {
      await _driver.clear();
      await _driver.add(user);
      await user.save();
      await FCMService().updateProfileFcmToken();
    } else {
      throw Exception("Could not determine user");
    }

  }

  static bool get isSignedIn => (_supplier.values.isNotEmpty || _driver.values.isNotEmpty);
  static bool get isDriver => _driver.values?.isNotEmpty;
  static bool get isSupplier => _supplier.values?.isNotEmpty;

  static SupplierModel get supplier => _supplier.values?.first;
  static Driver get driver => _driver.values?.first;

  static Future signOut() async {
    await HaweyatiService.post('auth/sign-out', {});
    await _supplier.clear();
    await _driver.clear();
  }

}



class _AppDataImpl implements AppData {
  String _city;
  String _address;
  LatLng _coordinates;

  Future _loadCache() async {
    final preferences = await SharedPreferences.getInstance();

    currentLocale.value = Locale.fromSubtags(
        languageCode: preferences.getString('locale') ?? 'en'
    );

    _city = preferences.getString('city');
    _address = preferences.getString('address');

    try {
      _coordinates = LatLng(
          preferences.getDouble('latitude'),
          preferences.getDouble('longitude')
      );
    } catch(e) {
      _coordinates = null;
    }
  }

  @override
  Future<void> burnFuse() async =>
      (await SharedPreferences.getInstance()).setBool('fuseBurnt', true);

  @override
  Future<bool> get isFuseBurnt async =>
      (await SharedPreferences.getInstance()).getBool('fuseBurnt') ?? false;

  @override String get city => _city;
  @override String get address => _address;
  @override LatLng get coordinates => _coordinates;

  @override
  set location(Location details) {
    _coordinates = LatLng(
        details.latitude,
        details.longitude
    );
    _city = details.city;
    _address = details.address;

    SharedPreferences.getInstance().then((value) {
      value.setString('city', _city);
      value.setString('address', _address);
      value.setDouble('latitude', _coordinates.latitude);
      value.setDouble('latitude', _coordinates.latitude);
      value.setDouble('longitude', _coordinates.longitude);
    });
  }

  @override
  Location get location {
    if (coordinates != null) {
      return Location(
          city: city, address: address,
          latitude: coordinates.latitude,
          longitude: coordinates.longitude
      );
    } else {
      return null;
    }
  }

  @override
  ValueNotifier<Locale> currentLocale = ValueNotifier(null);

  @override
  set locale(Locale _locale) {
    SharedPreferences.getInstance().then((value) {
      value.setString('locale', currentLocale.value.languageCode);
    });

    currentLocale.value = _locale;
  }
}