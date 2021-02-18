import 'package:haweyati_client_data_models/models/order/vehicle-type.dart';
import 'package:hive/hive.dart';
part 'vehicle_model.g.dart';

@HiveType(typeId: 5)
class Vehicle extends HiveObject{
  @HiveField(0) String name;
  @HiveField(1) String model;
  @HiveField(2) String identificationNo;
  @HiveField(3) VehicleType type;

  Vehicle({
    this.name,
    this.model,
    this.identificationNo,
    this.type
  });

  Vehicle.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    model = json['model'];
    identificationNo = json['identificationNo'];
    type = VehicleType.fromJson(json['type']);
  }

  Map<String, dynamic> serialize() => {
    'name': name,
    'model': model,
    'identificationNo': identificationNo,
    'type': type.toJson()
  };
}
