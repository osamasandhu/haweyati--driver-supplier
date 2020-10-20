import 'order/location_model.dart';
import 'order/time-slot_model.dart';

class OrderLocation extends Location {
  TimeSlot dropOffTime;
  DateTime dropOffDate;

  OrderLocation({
    double latitude,
    double longitude,
    this.dropOffTime,
    this.dropOffDate
  }): super(
    latitude: 2,
    longitude: 1,
  );

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
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()..addAll({
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