import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_client_data_models/const.dart';
import 'package:haweyati_client_data_models/models/hypertrack/trip_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'haweyati-service.dart';

class TripService extends HaweyatiService<Trip>{

  Future<Trip> createTrip(String orderId, LatLng pickup, LatLng dropOff,
      String deviceId, [bool start=true]) async {
    TripData tripData =  TripData();
    tripData.deviceId = deviceId;
    Destination pickupDestination = Destination(
        geometry: Geometry(
          type: 'Point',
          coordinates: [pickup.longitude,pickup.latitude],
        )
    );
      Destination dropOffDestination = Destination(
        geometry: Geometry(
            type: 'Point',
            coordinates: [dropOff.longitude,dropOff.latitude]
        ),
      );
    tripData.destination = start ? pickupDestination : dropOffDestination;

    var response = await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/trips"),
        body: jsonEncode(tripData),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Basic $hyperBasic"
        });
    print(response);
    print(response.body);
    var data = jsonDecode(response.body);
    return parse(data);
  }

  //New
  // Future<Trip> createTrip(String orderId,
  //     LatLng pickup,
  //     LatLng dropOff,
  //     String deviceId) async {
  //   var tripData =  TripData();
  //   tripData.deviceId = deviceId;
  //   var pickupDestination =  Destination(
  //     geometry: Geometry(
  //       type: 'Point',
  //       coordinates: [pickup.longitude,pickup.latitude],
  //     )
  //   );
  //   var dropOffDestination =  Destination(
  //     geometry: Geometry(
  //         type: 'Point',
  //         coordinates: [dropOff.longitude,dropOff.latitude]
  //     )
  //   );
  //   tripData.orders = [
  //     TripOrder(
  //       destination: pickupDestination,
  //       order_id: orderId,
  //       metadata: {'type' : 'pickup'}
  //     ),
  //     TripOrder(
  //         destination: dropOffDestination,
  //         order_id: orderId,
  //         metadata: {'type' : 'dropoff'}
  //     )
  //   ];
  //   var response = await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/trips"),
  //       body: jsonEncode(tripData),
  //       headers: {
  //         "Accept": "application/json",
  //         "Content-Type": "application/json",
  //         "Authorization":
  //         "Basic $hyperBasic"
  //       });
  //   print(response);
  //   print(response.body);
  //   var data = jsonDecode(response.body);
  //   return parse(data);
  // }

  Future<Trip> completeTrip(String tripId) async {
    var response = await http.post(Uri.encodeFull("https://v3.api.hypertrack.com/trips/$tripId/complete"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
          "Basic $hyperBasic"
        });
    return null;
  }

  Future<Trip> getTrip(String tripId) async {
    var response = await http.get(Uri.encodeFull("https://v3.api.hypertrack.com/trips/$tripId"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization":
          "Basic $hyperBasic"
        });
    var data = jsonDecode(response.body);
    return parse(data);
  }

  @override
  Trip parse(Map<String, dynamic> item) {
    return Trip.fromJson(item);
  }
}

class HyperRequestService {
  Future<List> fetch() async {
    var response = await http
        .get(Uri.encodeFull("https://v3.api.hypertrack.com/devices"), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Basic $hyperBasic"
    });

    var data = jsonDecode(response.body) as List;
    return data;
    // return data.map((item) => parse(item)).toList();
  }
}

class TripData {
  String deviceId;
  List<TripOrder> orders;
  Destination destination;

  TripData({this.deviceId, this.orders,this.destination});

  TripData.fromJson(Map<String, dynamic> json) {
    deviceId = json['device_id'];
    orders = json['orders'] != null
        ? json['orders'].map((e)=> TripOrder.fromJson(json[e])).toList()
        : null;
    destination = json['destination'] != null ? Destination.fromJson(json['destination']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_id'] = this.deviceId;
    if (this.orders != null) {
      data['orders'] = this.orders.map((e) => e.toJson()).toList();
    }
    if(this.destination!=null){
      data['destination'] = this.destination.toJson();
    }
    return data;
  }
}

class TripOrder{
  String order_id;
  Destination destination;
  Map<String,dynamic> metadata;
  String shareUrl;
  TripOrder({this.destination,this.metadata,this.order_id,this.shareUrl});

  TripOrder.fromJson(Map<String,dynamic> json) {
    destination = Destination.fromJson(json['destination']);
    metadata = json['metadata'];
    order_id = json['order_id'];
    shareUrl = json['share_url'];
  }

  Map<String,dynamic> toJson(){
    return {
      'order_id' : order_id,
      'metadata' : metadata,
      'share_url' : shareUrl,
      'destination' : destination.toJson()
    };
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  Map<String,dynamic> metadata;

  NearbyData({this.Hyperlocation, this.radius, this.lastUpdatedWithin,this.metadata});

  NearbyData.fromJson(Map<String, dynamic> json) {
    Hyperlocation = json['location'] != null
        ? new HyperLocation.fromJson(json['location'])
        : null;
    radius = json['radius'];
    lastUpdatedWithin = json['last_updated_within'];
    metadata = json['metadata'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.Hyperlocation != null) {
      data['location'] = this.Hyperlocation.toJson();
    }
    data['radius'] = this.radius;
    data['last_updated_within'] = this.lastUpdatedWithin;
    data['metadata'] = this.metadata;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}