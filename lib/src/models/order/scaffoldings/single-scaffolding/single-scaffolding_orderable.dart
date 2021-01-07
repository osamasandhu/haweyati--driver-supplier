import 'package:hive/hive.dart';
import '../../order-item_model.dart';
import 'single-scaffolding_model.dart';

class SingleScaffoldingOrderable extends OrderItem {
  @HiveField(1) int qty;
  @HiveField(2) int days;
  @HiveField(3) int wheels;
  @HiveField(4) int connections;
  @HiveField(5) String mesh;
  @HiveField(6) int meshQty;

  SingleScaffoldingOrderable({
    SingleScaffolding product,
    this.qty = 1,
    this.days = 0,
    this.wheels= 0,
    this.connections=0,
    this.mesh,
    this.meshQty= 1,
  }): super(product);

  static SingleScaffoldingOrderable fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return SingleScaffoldingOrderable(
        qty: json['qty'],
        days: json['days'],
        wheels: json['wheels'],
        connections: json['connections'],
        mesh: json['mesh'],
        meshQty: json['meshQty'],
        product: SingleScaffolding.fromJson(json['product']),
    );
  }
}
