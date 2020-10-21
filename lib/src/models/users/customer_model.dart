import 'package:haweyati_supplier_driver_app/model/json_serializable.dart';
import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:hive/hive.dart';

import '../location_model.dart';

part 'customer_model.g.dart';

@HiveType(typeId: 100)
class Customer extends HiveObject implements JsonSerializable {
  @HiveField(0) String id;
  @HiveField(1) String status;
  @HiveField(2) String message;
  @HiveField(3) Profile profile;
  @HiveField(4) Location location;

  String get name => profile.name;
  String get image => profile.image.name;

  Customer({
    this.id,
    this.status,
    this.message,
    this.profile,
    this.location
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['_id'],
      status: json['status'],
      message: json['message'],
      profile: json['profile'] != null ? Profile.fromJson(json['profile']) : null,
      location: json['location'] != null ? Location.fromJson(json['profile']) : null,
    );
  }

  @override
  Map<String, dynamic> serialize() => {
    '_id': id,
    'status': status,
    'message': message,
    'profile': profile.serialize(),
    'location': location.serialize(),
  };
}
