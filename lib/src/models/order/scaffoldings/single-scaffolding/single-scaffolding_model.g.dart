// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single-scaffolding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SingleScaffolding _$SingleScaffoldingFromJson(Map<String, dynamic> json) {
  return SingleScaffolding(
    type: json['type'] as String,
    description: json['description'] as String,
    pricing: (json['pricing'] as List)
        ?.map((e) => e == null ? null : SingleScaffoldingPricing.fromJson(e))
        ?.toList(),
  );
}

Map<String, dynamic> _$SingleScaffoldingToJson(SingleScaffolding instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('description', instance.description);
  writeNotNull('pricing', instance.pricing);
  return val;
}
