// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer-model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 4;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      location: fields[2] as HiveLocation,
      id: fields[0] as String,
      token: fields[3] as String,
      message: fields[4] as String,
      profile: fields[1] as PersonModel,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.profile)
      ..writeByte(2)
      ..write(obj.location)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.message)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
