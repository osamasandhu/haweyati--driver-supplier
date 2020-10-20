import 'package:haweyati_supplier_driver_app/model/common/location_model.dart';
import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:hive/hive.dart';
import 'vehicle_model.dart';
part 'driver_model.g.dart';

@HiveType(typeId: 1)
class DriverModel extends HiveObject {
  @HiveField(0) String sId;
  @HiveField(1) String city;
  @HiveField(2) String status;
  @HiveField(3) String license;
  @HiveField(4) Vehicle vehicle;
  @HiveField(5) HiveLocation location;
  @HiveField(6) PersonModel profile;
  @HiveField(7) String message;

  DriverModel({
    this.sId,
    this.city,
    this.status,
    this.message,
    this.license,
    this.vehicle,
    this.profile,
    this.location,
  });

  DriverModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    vehicle = json['vehicle'] != null ? new Vehicle.fromJson(json['vehicle']) : null;

    if (json['profile'] != null) {
      if (json['profile'] is String) {
        profile = PersonModel()..id = json['profile'];
      } else {
        profile = PersonModel.fromJson(json['profile']);
      }
    }
    license = json['license'];
    location = json['location'] != null
        ? new HiveLocation.fromJson(json['location'])
        : null;
    city = json['city'];
    message = json['message'];
  }

  Map<String, dynamic> serialize() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicle != null) {
      data['vehicle'] = this.vehicle.serialize();
    }
    if (this.profile != null) {
      data['profile'] = this.profile?.toJson();
    }
    data['status'] = this.status;
    data['_id'] = this.sId;

    data['license'] = this.license;
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['city'] = this.city;
    data['message'] = this.message;

    return data;
  }
}
