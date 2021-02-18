import 'dart:convert';
import 'package:hypertrack_plugin/hypertrack.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart' as d;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

abstract class HyperTrackService {
  static const key = 'C5UjSueGPM8WHSiJSIgglK_I12d-EbzBMPzu_WxCotSd1p1oorUdSE4eq4edqT7e0WJuvDgbgHGnldYWEGQo0g';

  static String deviceName = d.AppData.driver.profile.name;
  static HyperTrack sdk;
  static bool isInitialised = false;

 static Future<void> initializeSdk() async {
    HyperTrack.enableDebugLogging();
    // Initializer is just a helper class to get the actual sdk instance
    try {
      sdk = await HyperTrack.initialize(key);
      isInitialised = true;
      sdk.setDeviceName(deviceName);
      sdk.setDeviceMetadata({"vehicle": d.AppData.driver.vehicle.type.id});
      sdk.onTrackingStateChanged.listen((TrackingStateChange event) {

      });
    } catch (e) {
      print(e);
    }

    final dev = (sdk == null) ? "unknown" : await sdk.getDeviceId();
    SharedPreferences.getInstance().then((value) => value.setString('deviceId', dev));

  }
}


class HyperRequestService {
  static const bearer = 'ZXpnbzdIcE5Dd3BJSnUzNUY4Sk5rOXhLQUkwOjFxaVFPc0Q5X2JVUF9lTGJTN1NuRGI0dkdBQXNFRFBwbzl0c0pDaWdPRTlZcVNGdkFwcEVUQQ==';
  Future<List> fetch() async {
    var response = await http
        .get(Uri.encodeFull("https://v3.api.hypertrack.com/devices"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization":
      "Basic $bearer"
    });

    var data = jsonDecode(response.body) as List;
    return data;
    // return data.map((item) => parse(item)).toList();
  }

  Future<List> fetchNearby() async {
    var nearbyData = new NearbyData();
    var Hyperlocation = new HyperLocation();
    Hyperlocation.type = "Point";
    Hyperlocation.coordinates = [71.505247, 30.191109, 76.96];
    nearbyData.Hyperlocation = Hyperlocation;
    nearbyData.radius = 1000;
    nearbyData.lastUpdatedWithin = 24;
    print(nearbyData.toJson());
    var response =
    await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/devices/nearby"),
        body: jsonEncode(nearbyData),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
          "Basic $bearer"
        });
    print(response);
    var data = jsonDecode(response.body);
    print(data['data']);
    return data['data'] as List;
    // return data.map((item) => parse(item)).toList();
  }
  Future createTrip() async {
    var tripData = new TripData();
    var destination = new Destination();
    var geometry = new Geometry();
    geometry.type = "Point";
    geometry.coordinates = [71.525008,30.169112];
    destination.geometry = geometry;
    tripData.deviceId = 'B4DF3A49-F288-4080-9AB8-E3D5CED4E355';
    tripData.destination = destination;
    print(tripData.toJson());
    var response =
    await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/trips"),
        body: jsonEncode(tripData),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
          "Basic $bearer"
        });
    print(response);
    var data = jsonDecode(response.body);
    print(data);
    return data;
    // return data.map((item) => parse(item)).toList();
  }
}

class TripData {
  String deviceId;
  Destination destination;

  TripData({this.deviceId, this.destination});

  TripData.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    destination = json['destination'] != null
        ? new Destination.fromJson(json['destination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    if (this.destination != null) {
      data['destination'] = this.destination.toJson();
    }
    return data;
  }
}

class Destination {
  Geometry geometry;

  Destination({this.geometry});

  Destination.fromJson(Map<String, dynamic> json) {
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.geometry != null) {
      data['geometry'] = this.geometry.toJson();
    }
    return data;
  }
}

class Geometry {
  String type;
  List<double> coordinates;

  Geometry({this.type, this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class NearbyData {
  HyperLocation Hyperlocation;
  int radius;
  int lastUpdatedWithin;

  NearbyData({this.Hyperlocation, this.radius, this.lastUpdatedWithin});

  NearbyData.fromJson(Map<String, dynamic> json) {
    Hyperlocation = json['Hyperlocation'] != null
        ? new HyperLocation.fromJson(json['Hyperlocation'])
        : null;
    radius = json['radius'];
    lastUpdatedWithin = json['last_updated_within'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.Hyperlocation != null) {
      data['Hyperlocation'] = this.Hyperlocation.toJson();
    }
    data['radius'] = this.radius;
    data['last_updated_within'] = this.lastUpdatedWithin;
    return data;
  }
}

class HyperLocation {
  String type;
  List<double> coordinates;

  HyperLocation({this.type, this.coordinates});

  HyperLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}