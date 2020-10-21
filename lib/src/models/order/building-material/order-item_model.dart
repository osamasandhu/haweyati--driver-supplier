import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/building-material/model.dart';
import 'package:hive/hive.dart';

part 'order-item_model.g.dart';

@HiveType(typeId: 52)
class BuildingMaterialOrderItem extends OrderItem {
  @HiveField(1) int qty;
  @HiveField(2) String size;
  @HiveField(3) double price;

  BuildingMaterialOrderItem({
    BuildingMaterial product,
    this.size,
    this.qty = 0,
    this.price = 0.0,
  }): super(product);

  static BuildingMaterialOrderItem fromJson(Map<String, dynamic> json) {
    return BuildingMaterialOrderItem(
      qty: json['qty'],
      size: json['size'],
      price: json['price']?.toDouble(),
      product: BuildingMaterial.fromJson(json['product'])
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()
      ..addAll({
        'qty': qty,
        'size': size,
        'price': price
      });
}