import 'package:flutter/cupertino.dart';
import 'package:haweyati_client_data_models/models/image_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../image_model.dart';
part 'delivery-vehicle_model.g.dart';

@JsonSerializable(includeIfNull: false)
class DeliveryVehicle extends Orderable {
  @HiveField(1)
  String name;
  @HiveField(2)
  ImageModel image;
  @HiveField(3)
  double minWeight;
  @HiveField(4)
  double maxWeight;
  @HiveField(5)
  double minVolume;
  @HiveField(6)
  double maxVolume;
  @HiveField(7)
  double deliveryCharges;
  DeliveryVehicle({this.name, this.image,
    this.deliveryCharges,
    this.minWeight, this.maxWeight,this.maxVolume,this.minVolume});

  Map<String, dynamic> toJson() => _$DeliveryVehicleToJson(this);
  factory DeliveryVehicle.fromJson(json) => _$DeliveryVehicleFromJson(json);

  @override
  Map<String, dynamic> serialize() {
    return {};
  }

}
