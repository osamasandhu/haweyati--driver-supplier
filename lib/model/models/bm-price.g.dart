// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bm-price.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BMPriceAdapter extends TypeAdapter<BMPrice> {
  @override
  final int typeId = 14;

  @override
  BMPrice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BMPrice();
  }

  @override
  void write(BinaryWriter writer, BMPrice obj) {
    writer..writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BMPriceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
