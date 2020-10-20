// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building-material_sublist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMProductAdapter extends TypeAdapter<BMProduct> {
  @override
  final int typeId = 10;

  @override
  BMProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMProduct(
      suppliers: (fields[0] as List)?.cast<SupplierModel>(),
      sId: fields[1] as String,
      name: fields[2] as String,
      parent: fields[4] as String,
      description: fields[3] as String,
      pricing: (fields[5] as List)?.cast<BMPricing>(),
      image: fields[6] as Images,
      iV: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BMProduct obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.suppliers)
      ..writeByte(1)
      ..write(obj.sId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.parent)
      ..writeByte(5)
      ..write(obj.pricing)
      ..writeByte(6)
      ..write(obj.image)
      ..writeByte(7)
      ..write(obj.iV);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
