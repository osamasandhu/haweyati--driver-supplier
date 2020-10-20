import 'package:haweyati_supplier_driver_app/model/order/services/finishing-material/model.dart';
import 'package:hive/hive.dart';

import '../order-item_model.dart';

part 'order-item_model.g.dart';

@HiveType(typeId: 50)
class FinishingMaterialOrderItem extends OrderItem {
  @HiveField(1) int qty;
  @HiveField(2) double price;
  @HiveField(3) Map<String, dynamic> variants;

  FinishingMaterialOrderItem({
    FinishingMaterial product,
    this.qty = 0,
    this.price = 0.0,
    this.variants = const {},
  }): super(product);

  static FinishingMaterialOrderItem fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return FinishingMaterialOrderItem(
      qty: json['qty'],
      price: json['price']?.toDouble(),
      variants: json['variants'],
      product: FinishingMaterial.fromJson(json['product'])
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()
      ..addAll({
        'qty': qty,
        'price': price,
        'variants': variants
      });
}