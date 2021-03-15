import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:hive/hive.dart';
import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/vehicle_model.dart';
part 'driver_model.g.dart';

@HiveType(typeId: 1)
class Driver extends HiveObject {
  @HiveField(0) String sId;
  @HiveField(1) String city;
  @HiveField(2) String status;
  @HiveField(3) String license;
  @HiveField(4) Vehicle vehicle;
  @HiveField(5) Location location;
  @HiveField(6) Profile profile;
  @HiveField(7) String message;
  @HiveField(9) double rating;

  Driver({
    this.sId,
    this.city,
    this.status,
    this.message,
    this.license,
    this.vehicle,
    this.profile,
    this.location,
    this.rating,
  });

  Driver.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    vehicle = json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;
    if (json['profile'] != null) {
      if (json['profile'] is String) {
        profile = Profile()..id = json['profile'];
      } else {
        profile = Profile.fromJson(json['profile']);
      }
    }
    license = json['license'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    city = json['city'];
    message = json['message'];
    rating = json['rating'];
  }

  Map<String, dynamic> serialize() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.serialize();
    }
    if (this.profile != null) {
      data['profile'] = this.profile.serialize();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['license'] = this.license;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['city'] = this.city;
    data['message'] = this.message;
    data['rating'] = this.rating;
    return data;
  }
}
