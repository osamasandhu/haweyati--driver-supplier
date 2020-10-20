// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductOptionAdapter extends TypeAdapter<ProductOption> {
  @override
  final int typeId = 17;

  @override
  ProductOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductOption(
      sId: fields[0] as String,
      optionValues: fields[2] as String,
      optionName: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductOption obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.optionName)
      ..writeByte(2)
      ..write(obj.optionValues);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
