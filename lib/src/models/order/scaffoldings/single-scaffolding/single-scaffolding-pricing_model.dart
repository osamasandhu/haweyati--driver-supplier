import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'mesh-type_model.dart';
part 'single-scaffolding-pricing_model.g.dart';

@JsonSerializable(includeIfNull: false)
class SingleScaffoldingPricing extends JsonSerializable {
  @HiveField(1)
  String city;
  @HiveField(2)
  Mesh mesh;
  @HiveField(3)
  double wheels;
  @HiveField(4)
  double rent;
  @HiveField(5)
  int days;
  @HiveField(6)
  double extraDayRent;
  @HiveField(7)
  double connections;
  SingleScaffoldingPricing({this.mesh,this.city,this.days,
  this.extraDayRent,this.rent,this.wheels});

  Map<String, dynamic> toJson() => _$SingleScaffoldingPricingToJson(this);
  factory SingleScaffoldingPricing.fromJson(json) => _$SingleScaffoldingPricingFromJson(json);
}
