// // GENERATED CODE - DO NOT MODIFY BY HAND
//
// part of 'location_model.dart';
//
// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************
//
// class LocationAdapter extends TypeAdapter<Location> {
//   @override
//   final int typeId = 103;
//
//   @override
//   Location read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Location(
//       city: fields[0] as String,
//       address: fields[1] as String,
//       latitude: fields[2] as double,
//       longitude: fields[3] as double,
//     );
//   }
//
//   @override
//   void write(BinaryWriter writer, Location obj) {
//     writer
//       ..writeByte(4)
//       ..writeByte(0)
//       ..write(obj.city)
//       ..writeByte(1)
//       ..write(obj.address)
//       ..writeByte(2)
//       ..write(obj.latitude)
//       ..writeByte(3)
//       ..write(obj.longitude);
//   }
//
//   @override
//   int get hashCode => typeId.hashCode;
//
//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is LocationAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
