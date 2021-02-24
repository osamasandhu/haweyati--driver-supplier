import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/time-slot_model.dart';

class OrderLocation extends Location {
  TimeSlot dropOffTime;
  DateTime dropOffDate;
  String address;
  double latitude;
  double longitude;

  OrderLocation({
    this.address,
    this.latitude,
    this.longitude,
    this.dropOffTime,
    this.dropOffDate
  });

  update(Location location) {
    city = location?.city;
    address = location?.address;
    latitude = location?.latitude;
    longitude = location?.longitude;
  }

  factory OrderLocation.fromJson(Map<String, dynamic> json) {
    final location = Location.fromJson(json['dropoffLocation']);
    return OrderLocation(
      latitude: location.latitude,
      longitude: location.longitude,
      dropOffTime: TimeSlot.fromJson(json['dropoffTime']),
      dropOffDate: json['dropoffDate'] != null ? DateTime.parse(json['dropoffDate']) : null,
    )..address = json['dropoffAddress'];
  }

  @override
  Map<String, dynamic> serialize() => super.toJson()..addAll({
    'dropoffAddress': address,
    'dropoffTime': dropOffTime?.serialize(),
    'dropoffDate': dropOffDate?.millisecondsSinceEpoch,
  });
}

class RentableOrderLocation extends OrderLocation {
  TimeSlot pickUpTime;
  DateTime pickUpDate;

  RentableOrderLocation();

  factory RentableOrderLocation.fromLocation(Location location) {
    return RentableOrderLocation()
      ..city = location?.city
      ..address = location?.address
      ..latitude = location?.latitude
      ..longitude = location?.longitude;
  }

  factory RentableOrderLocation.from(OrderLocation location) {
    return RentableOrderLocation()
      ..city = location?.city
      ..address = location?.address
      ..latitude = location?.latitude
      ..longitude = location?.longitude
      ..dropOffTime = location?.dropOffTime
      ..dropOffDate = location?.dropOffDate;
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()..addAll({
    'pickUpTime': pickUpTime?.serialize(),
    'pickUpDate': pickUpDate?.millisecondsSinceEpoch,
  });
}