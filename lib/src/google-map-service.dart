import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = "AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w";

class GoogleMapsServices{

//  30.202299, 71.515378
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2)async{
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=30.1575,71.5249&waypoints=31.5204,74.3587&key=AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w&destination=33.6844,73.0479";
//    String url = "https://maps.googleapis.com/maps/api/directions/json?"
//        "origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    print(url);
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}