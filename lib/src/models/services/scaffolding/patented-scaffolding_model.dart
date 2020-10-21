import 'package:haweyati_supplier_driver_app/model/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/scaffolding-item_model.dart';

class PatentedScaffolding extends Orderable {
  ScaffoldingItem standardBars;
  ScaffoldingItem ledgerBars;
  ScaffoldingItem adjustableBase;
  ScaffoldingItem stabilizers;
  ScaffoldingItem stairs;
  ScaffoldingItem woodPlanks;

  PatentedScaffolding({
    this.standardBars,
    this.ledgerBars,
    this.adjustableBase,
    this.stabilizers,
    this.stairs,
    this.woodPlanks
  }) {
    stairs ??= ScaffoldingItem();
    ledgerBars ??= ScaffoldingItem();
    woodPlanks ??= ScaffoldingItem();
    stabilizers ??= ScaffoldingItem();
    standardBars ??= ScaffoldingItem();
    adjustableBase ??= ScaffoldingItem();
  }

  factory PatentedScaffolding.fromJson(Map<String, dynamic> json) {
    return PatentedScaffolding(
      standardBars: ScaffoldingItem.fromJson(json['standardBars']),
      ledgerBars: ScaffoldingItem.fromJson(json['ledgerBars']),
      adjustableBase: ScaffoldingItem.fromJson(json['adjustableBase']),
      stabilizers: ScaffoldingItem.fromJson(json['stabilizers']),
      stairs: ScaffoldingItem.fromJson(json['stairs']),
      woodPlanks: ScaffoldingItem.fromJson(json['woodPlanks'])
    );
  }

  @override
  Map<String, dynamic> serialize() => {
    'standardBars': standardBars.serialize(),
    'ledgerBars': ledgerBars.serialize(),
    'adjustableBase': adjustableBase.serialize(),
    'stabilizers': stabilizers.serialize(),
    'stairs': stairs.serialize(),
    'woodPlanks': woodPlanks.serialize()
  };
}