import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/finishing-material/model.dart';
import 'package:hive/hive.dart';

part 'order-item_model.g.dart';

@HiveType(typeId: 50)
class FinishingMaterialOrderItem extends OrderItem {
  @HiveField(1) int qty;
  @HiveField(2) double price;
  @HiveField(3) Map<String, dynamic> variants;
  @HiveField(4) bool selected;

  FinishingMaterialOrderItem({
    FinishingMaterial product,
    this.qty = 0,
    this.price = 0.0,
    this.variants = const {},
    this.selected = false,
  }): super(product);

  static FinishingMaterialOrderItem fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return FinishingMaterialOrderItem(
      qty: json['qty'],
      price: json['price']?.toDouble(),
      variants: json['variants'],
        selected: json['selected'] ?? false,
      product: FinishingMaterial.fromJson(json['product'])
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()
      ..addAll({
        'qty': qty,
        'price': price,
        'variants': variants,
        'selected' : selected
      });
}