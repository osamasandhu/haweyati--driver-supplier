import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderLocation{
  LatLng cords;
  String address;
  String city;
  OrderLocation({this.cords,this.address,this.city});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cords'] = this.cords;
    data['address'] = this.address;
    data['city'] = this.city;
    return data;
  }

}