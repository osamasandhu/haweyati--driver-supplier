import 'package:haweyati_supplier_driver_app/model/json_serializable.dart';
import 'package:haweyati_supplier_driver_app/src/models/time-slot_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';

class DropOff implements JsonSerializable {
  DateTime date;
  TimeSlot time;
  Location location;

  DropOff({
    this.date,
    this.time,
    this.location
  });

  factory DropOff.fromJson(Map<String, dynamic> json) {
    return DropOff(
      date: json['date'],
      time: TimeSlot.fromJson(json['time']),
      location: Location.fromJson(json['location'])
    );
  }

  @override
  Map<String, dynamic> serialize() => {
    ///TODO: Prettify the object

    'dropoffDate': date,
    'dropoffTime': time.serialize(),
    'dropoffAddress': location.address,
    'dropoffLocation': {
      'latitude': location.latitude,
      'longitude': location.longitude
    }
  };
}