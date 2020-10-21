import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/services/scaffolding/scaffolding-item_model.dart';

class SteelScaffolding extends Orderable {
  ScaffoldingItem mainFrame;
  ScaffoldingItem crossBrace;
  ScaffoldingItem woodPlanks;
  ScaffoldingItem stabilizers;
  ScaffoldingItem connectingBars;
  ScaffoldingItem adjustableBase;

  SteelScaffolding({
    this.mainFrame,
    this.crossBrace,
    this.woodPlanks,
    this.stabilizers,
    this.connectingBars,
    this.adjustableBase
  });

  factory SteelScaffolding.fromJson(Map<String, dynamic> json) {
    return SteelScaffolding(
      mainFrame: ScaffoldingItem.fromJson(json['mainFrame']),
      crossBrace: ScaffoldingItem.fromJson(json['crossBrace']),
      woodPlanks: ScaffoldingItem.fromJson(json['woodPlanks']),
      stabilizers: ScaffoldingItem.fromJson(json['stabilizers']),
      connectingBars: ScaffoldingItem.fromJson(json['connectingBars']),
      adjustableBase: ScaffoldingItem.fromJson(json['adjustableBase']),
    );
  }

  @override
  Map<String, dynamic> serialize() => {
    'mainFrame': mainFrame.serialize(),
    'crossBrace': crossBrace.serialize(),
    'woodPlanks': woodPlanks.serialize(),
    'stabilizers': stabilizers.serialize(),
    'connectingBars': connectingBars.serialize(),
    'adjustableBase': adjustableBase.serialize()
  };
}