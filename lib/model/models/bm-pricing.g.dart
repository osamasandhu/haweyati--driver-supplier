// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bm-pricing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMPricingAdapter extends TypeAdapter<BMPricing> {
  @override
  final int typeId = 15;

  @override
  BMPricing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMPricing(
      city: fields[0] as String,
    )..sId = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, BMPricing obj) {
    writer
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.sId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMPricingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
