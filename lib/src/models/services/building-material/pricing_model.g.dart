// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pricing_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuildingMaterialPricingAdapter
    extends TypeAdapter<BuildingMaterialPricing> {
  @override
  final int typeId = 15;

  @override
  BuildingMaterialPricing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuildingMaterialPricing(
      city: fields[1] as String,
      price12yard: fields[3] as double,
      price20yard: fields[2] as double,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, BuildingMaterialPricing obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.price20yard)
      ..writeByte(3)
      ..write(obj.price12yard);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingMaterialPricingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
