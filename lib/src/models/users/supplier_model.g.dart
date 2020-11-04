// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplier_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SupplierModelAdapter extends TypeAdapter<SupplierModel> {
  @override
  final int typeId = 2;

  @override
  SupplierModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SupplierModel(
      services: (fields[6] as List)?.cast<String>(),
      person: fields[4] as Profile,
      city: fields[1] as String,
      location: fields[3] as Location,
      id: fields[0] as String,
      shopParentId: fields[5] as String,
      message: fields[7] as String,
      status: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SupplierModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.city)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.location)
      ..writeByte(4)
      ..write(obj.person)
      ..writeByte(5)
      ..write(obj.shopParentId)
      ..writeByte(6)
      ..write(obj.services)
      ..writeByte(7)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupplierModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
