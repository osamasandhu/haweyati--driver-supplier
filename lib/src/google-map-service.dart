import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = "AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w";

class GoogleMapsServices{

//  30.202299, 71.515378
  Future<String> getRouteCoordinates(LatLng currentLocation,List<LatLng> waypoints)async{
    // String url = "https://maps.googleapis.com/maps/api/directions/json?origin=${currentLocation.latitude},${currentLocation.longitude}&waypoints=${l1.latitude},${l1.longitude}&key=AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w&destination=33.6844,73.0479";
    StringBuffer query = StringBuffer('https://maps.googleapis.com/maps/api/directions/json?origin=');
    query.write('${currentLocation.latitude},${currentLocation.longitude}');
    for(var waypoint in waypoints){
      query.write('&waypoints=');
      query.write('${waypoint.latitude},${waypoint.longitude}');
    }
    query.write('&key=AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w');
    query.write('&destination=${waypoints[waypoints.length-1].latitude},${waypoints[waypoints.length-1].longitude}');
    print(query.toString());
    http.Response response = await http.get(query.toString());
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}