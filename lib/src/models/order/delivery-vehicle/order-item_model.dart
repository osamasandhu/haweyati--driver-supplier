import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:hive/hive.dart';
import '../order-location_model.dart';
import 'delivery-vehicle_model.dart';
part 'order-item_model.g.dart';

@HiveType(typeId: 50)
class DeliveryVehicleOrderItem extends OrderItem {
  @HiveField(1) int qty;
  @HiveField(2) double distance;
  @HiveField(3) Location pickUp;

  DeliveryVehicleOrderItem({
    DeliveryVehicle product,
    this.qty = 1,
    this.distance,
    this.pickUp,
  }): super(product);

  static DeliveryVehicleOrderItem fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DeliveryVehicleOrderItem(
      qty: json['qty'],
      distance: json['price']?.toDouble(),
      product: DeliveryVehicle.fromJson(json['product']),
      pickUp: Location.fromJson(json['pickUpLocation'])
    );

  }

}