import 'package:haweyati_supplier_driver_app/model/order/services/dumpster/model.dart';
import 'package:hive/hive.dart';
import '../order-item_model.dart';
part 'order-item_model.g.dart';

@HiveType(typeId: 51)
class DumpsterOrderItem extends OrderItem {
  @HiveField(1) int extraDays;
  @HiveField(2) double extraDaysPrice;

  DumpsterOrderItem({
    Dumpster product,
    this.extraDays = 0,
    this.extraDaysPrice = 0
  }): super(product);

  static DumpsterOrderItem fromJson(Map<String, dynamic> json) {
    return DumpsterOrderItem(
      product: Dumpster.fromJson(json['product']),
      extraDays: json['extraDays'],
      extraDaysPrice: json['extraDaysPrice']?.toDouble()
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()
      ..addAll({
        'extraDays': extraDays,
        'extraDaysPrice': extraDaysPrice
      });
}