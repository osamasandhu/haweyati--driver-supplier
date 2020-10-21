import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/scaffolding-item_model.dart';

enum SingleScaffoldingType {
  halfSteel, fullSteel
}

class SingleScaffolding extends Orderable {
  ScaffoldingItem item;
  SingleScaffoldingType type;

  @override
  Map<String, dynamic> serialize() => {
    'item': item.serialize(), 'isFullSteel': resolveType(type)
  };

  SingleScaffolding({
    ScaffoldingItem item,
    SingleScaffoldingType type
  }) {
    this.item ??= ScaffoldingItem();
  }

  factory SingleScaffolding.fromJson(Map<String, dynamic> json) {
    return SingleScaffolding(
      type: parseType(json['isFullSteel']),
      item: ScaffoldingItem.fromJson(json['item'])
    );
  }

  static parseType(bool value) {
    return value
      ? SingleScaffoldingType.fullSteel
      : SingleScaffoldingType.halfSteel;
  }

  static resolveType(SingleScaffoldingType type) {
    return type == SingleScaffoldingType.fullSteel;
  }
}