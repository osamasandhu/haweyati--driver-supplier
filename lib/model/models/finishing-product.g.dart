// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finishing-product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinProductAdapter extends TypeAdapter<FinProduct> {
  @override
  final int typeId = 16;

  @override
  FinProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinProduct(
      suppliers: (fields[0] as List)?.cast<SupplierModel>(),
      sId: fields[1] as String,
      price: fields[2] as double,
      name: fields[3] as String,
      variants: (fields[7] as List)
          ?.map((dynamic e) => (e as Map)?.cast<String, dynamic>())
          ?.toList(),
      parent: fields[5] as String,
      description: fields[4] as String,
      options: (fields[6] as List)?.cast<ProductOption>(),
      images: fields[8] as Images,
      iV: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, FinProduct obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.suppliers)
      ..writeByte(1)
      ..write(obj.sId)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.parent)
      ..writeByte(6)
      ..write(obj.options)
      ..writeByte(7)
      ..write(obj.variants)
      ..writeByte(8)
      ..write(obj.images)
      ..writeByte(9)
      ..write(obj.iV);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
