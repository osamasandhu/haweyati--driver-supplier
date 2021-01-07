// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single-scaffolding-pricing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleScaffoldingPricing _$SingleScaffoldingPricingFromJson(
    Map<String, dynamic> json) {
  return SingleScaffoldingPricing(
    mesh: json['mesh'] == null ? null : Mesh.fromJson(json['mesh']),
    city: json['city'] as String,
    days: json['days'] as int,
    extraDayRent: (json['extraDayRent'] as num)?.toDouble(),
    rent: (json['rent'] as num)?.toDouble(),
    wheels: (json['wheels'] as num)?.toDouble(),
  )..connections = (json['connections'] as num)?.toDouble();
}

Map<String, dynamic> _$SingleScaffoldingPricingToJson(
    SingleScaffoldingPricing instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('city', instance.city);
  writeNotNull('mesh', instance.mesh);
  writeNotNull('wheels', instance.wheels);
  writeNotNull('rent', instance.rent);
  writeNotNull('days', instance.days);
  writeNotNull('extraDayRent', instance.extraDayRent);
  writeNotNull('connections', instance.connections);
  return val;
}
