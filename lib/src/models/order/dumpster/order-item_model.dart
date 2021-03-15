import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/dumpster/model.dart';
import 'package:hive/hive.dart';

part 'order-item_model.g.dart';

@HiveType(typeId: 51)
class DumpsterOrderItem extends OrderItem {
  @HiveField(1) int extraDays;
  @HiveField(2) double extraDaysPrice;
  int qty;

  DumpsterOrderItem({
    Dumpster product,
    this.extraDays = 0,
    this.extraDaysPrice = 0,
    this.qty= 0
  }): super(product);

  static DumpsterOrderItem fromJson(Map<String, dynamic> json) {
    return DumpsterOrderItem(
      product: Dumpster.fromJson(json['product']),
      extraDays: json['extraDays'],
      extraDaysPrice: json['extraDaysPrice']?.toDouble(),
      qty: json['qty']?.toInt()
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()
      ..addAll({
        'extraDays': extraDays,
        'extraDaysPrice': extraDaysPrice
      });
}