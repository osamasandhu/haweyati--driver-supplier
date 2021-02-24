import 'package:haweyati_client_data_models/const.dart';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart' as d;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class HyperTrackService {

  static String deviceName = d.AppData.driver.profile.name;
  static HyperTrack sdk;
  static bool isInitialised = false;

 static Future<void> initializeSdk() async {
    HyperTrack.enableDebugLogging();
    try {
      sdk = await HyperTrack.initialize(hyperKey);
      isInitialised = true;
      sdk.setDeviceName(deviceName);
      sdk.setDeviceMetadata({"vehicle": d.AppData.driver.vehicle.type.id});
      sdk.onTrackingStateChanged.listen((TrackingStateChange event) {});
    } catch (e) {
      print("ERRRROR");
      print(e);
    }

    final dev = (sdk == null) ? "unknown" : await sdk.getDeviceId();
    SharedPreferences.getInstance().then((value) => value.setString('deviceId', dev));

  }
}

