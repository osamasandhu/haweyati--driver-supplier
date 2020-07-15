import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserLocation{
  LatLng cords;
  String address;
  String city;
  UserLocation({this.cords,this.address,this.city});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cords'] = this.cords;
    data['city'] = this.city;
    data['address'] = this.address;
    return data;
  }

}