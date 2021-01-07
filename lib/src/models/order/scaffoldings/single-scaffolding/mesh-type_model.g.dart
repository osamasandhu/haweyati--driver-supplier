// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mesh-type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mesh _$MeshFromJson(Map<String, dynamic> json) {
  return Mesh(
    half: (json['half'] as num)?.toDouble(),
    full: (json['full'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$MeshToJson(Mesh instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('half', instance.half);
  writeNotNull('full', instance.full);
  return val;
}
