import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../order-item_model.dart';
import 'mesh-type_model.dart';
import 'single-scaffolding-pricing_model.dart';
part 'single-scaffolding_model.g.dart';

@JsonSerializable(includeIfNull: false)
class SingleScaffolding extends Orderable {
  @HiveField(1)
  String type;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<SingleScaffoldingPricing> pricing;
  SingleScaffolding({this.type,this.description,this.pricing});

  int get days => pricing.first.days;
  double get rent => pricing.first.rent;
  Mesh get mesh => pricing.first.mesh;
  double get extraDayRent => pricing.first.extraDayRent;
  double get wheels => pricing.first.wheels;
  double get connections => pricing.first.connections;
  double meshPrice (String type) => type == 'half' ? mesh.half : mesh.full;

  Map<String, dynamic> toJson() => _$SingleScaffoldingToJson(this);
  factory SingleScaffolding.fromJson(json) {
    final dumpster = _$SingleScaffoldingFromJson(json);
    return dumpster;
  }

  @override
  Map<String, dynamic > serialize() {
    return {};
  }
}
