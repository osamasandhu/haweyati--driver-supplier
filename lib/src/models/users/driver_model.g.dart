// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'driver_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverModelAdapter extends TypeAdapter<Driver> {
  @override
  final int typeId = 1;

  @override
  Driver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Driver(
      sId: fields[0] as String,
      city: fields[1] as String,
      status: fields[2] as String,
      message: fields[7] as String,
      license: fields[3] as String,
      vehicle: fields[4] as Vehicle,
      profile: fields[6] as Profile,
      location: fields[5] as Location,
    );
  }

  @override
  void write(BinaryWriter writer, Driver obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.license)
      ..writeByte(4)
      ..write(obj.vehicle)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.profile)
      ..writeByte(7)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}