
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rent_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RentAdapter extends TypeAdapter<Rent> {
  @override
  final int typeId = 21;

  @override
  Rent read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Rent(
      id: fields[0] as String,
      city: fields[2] as String,
      rent: fields[3] as double,
      days: fields[1] as int,
      extraDayRent: fields[5] as double,
      helperPrice: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Rent obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.rent)
      ..writeByte(4)
      ..write(obj.helperPrice)
      ..writeByte(5)
      ..write(obj.extraDayRent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
