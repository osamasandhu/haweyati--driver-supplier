import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/patented-scaffolding_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/scaffolding-types.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/single-scaffolding_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/steel-scaffolding_model.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 50)
class ScaffoldingOrderItem extends OrderItem {
  ScaffoldingType type;

  ScaffoldingOrderItem({
    Orderable product,
    this.type
  }): super(product);

  static ScaffoldingOrderItem fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    Orderable product;
    final int type = json['type'];

    switch (ScaffoldingType.values[type]) {
      case ScaffoldingType.steel:
        product = SteelScaffolding.fromJson(json['product']);
        break;
      case ScaffoldingType.single:
        product = SingleScaffolding.fromJson(json['product']);
        break;
      case ScaffoldingType.patented:
        product = PatentedScaffolding.fromJson(json['product']);
        break;
    }

    return ScaffoldingOrderItem(
      product: product, type: json['type']
    );
  }

  @override
  Map<String, dynamic> serialize() => super.serialize()
    ..addAll({'type': type.index});
}