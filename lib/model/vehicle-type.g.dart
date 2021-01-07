// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle-type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleTypeAdapter extends TypeAdapter<VehicleType> {
  @override
  final int typeId = 3;

  @override
  VehicleType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleType(
      image: fields[3] as Images,
      name: fields[0] as String,
      minVolume: fields[2] as double,
      minWeight: fields[1] as double,
      id: fields[4] as String,
      maxVolume: fields[6] as double,
      maxWeight: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.minWeight)
      ..writeByte(2)
      ..write(obj.minVolume)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.maxWeight)
      ..writeByte(6)
      ..write(obj.maxVolume);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is VehicleTypeAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}
