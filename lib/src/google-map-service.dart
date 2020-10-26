import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
const apiKey = "AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w";

class GoogleMapsServices{

  Future<String> getRouteCoordinates(LatLng currentLocation,List<LatLng> waypoints,LatLng destination)async{
    StringBuffer query = StringBuffer('https://maps.googleapis.com/maps/api/directions/json?origin=');
    query.write('${currentLocation.latitude},${currentLocation.longitude}');
    query.write('&waypoints=');
    for(var waypoint in waypoints){
      // query.write('via:-${waypoint.latitude},${waypoint.longitude}|');
      query.write('${waypoint.latitude},${waypoint.longitude}|');
    }
    query.write('&key=AIzaSyDdNpY6LGWgHqRfTRZsKkVhocYOaER325w');
    query.write('&destination=${destination.latitude},${destination.longitude}');
    print(query.toString());
    http.Response response = await http.get(query.toString());
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}