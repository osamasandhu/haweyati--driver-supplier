// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dumpster_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DumpsterAdapter extends TypeAdapter<Dumpster> {
  @override
  final int typeId = 20;

  @override
  Dumpster read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dumpster(
      id: fields[0] as String,
      size: fields[1] as String,
      image: fields[5] as Images,
      pricing: (fields[3] as List)?.cast<Rent>(),
      suppliers: (fields[4] as List)?.cast<String>(),
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dumpster obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.size)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pricing)
      ..writeByte(4)
      ..write(obj.suppliers)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DumpsterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
