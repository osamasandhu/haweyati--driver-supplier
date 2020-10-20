import 'package:hive/hive.dart';
part 'location_model.g.dart';

@HiveType(typeId: 9)
class HiveLocation extends HiveObject {
  @HiveField(0)
  double latitude;
  @HiveField(1)
  double longitude;
  @HiveField(2)
  String address;
  HiveLocation({this.longitude,this.latitude,this.address});

  HiveLocation.fromJson(Map<String, dynamic> json) {
    longitude = double.parse(json['longitude'].toString());
    latitude = double.parse(json['latitude'].toString());
    address = json['address'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['address'] = this.address;
    return data;
  }

}