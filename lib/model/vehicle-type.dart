// import 'package:haweyati_supplier_driver_app/src/models/image_model.dart';
// import 'package:hive/hive.dart';
//
// import 'models/images_model.dart';
//
// part 'vehicle-type.g.dart';
//
// @HiveType(typeId: 3)
// class VehicleType extends HiveObject{
//   @HiveField(0)
//   String name;
//   @HiveField(1)
//   double minWeight;
//   @HiveField(2)
//   double minVolume;
//   @HiveField(3)
//   Images image;
//   @HiveField(4)
//   String id;
//   @HiveField(5)
//   double maxWeight;
//   @HiveField(6)
//   double maxVolume;
//   @HiveField(7)
//   double deliveryCharges;
//
//   VehicleType({this.image,this.name,this.minVolume,this.minWeight,this.id,this.maxVolume,this.maxWeight,this.deliveryCharges});
//
//   VehicleType.fromJson(Map<String,dynamic> json){
//     id = json['_id'];
//     name = json['name'];
//     minWeight = double.tryParse(json['minWeight'].toString()) ?? 0.0;
//     maxWeight = double.tryParse(json['maxWeight'].toString()) ?? 0.0;
//     minVolume = double.tryParse(json['minVolume'].toString()) ?? 0.0;
//     maxVolume = double.tryParse(json['maxVolume'].toString()) ?? 0.0;
//     deliveryCharges = double.tryParse(json['deliveryCharges'].toString()) ?? 0.0;
//     image = Images.fromJson(json['image']);
//   }
//
//   Map<String,dynamic> toJson()=> {'name' : name,'minWeight' : minWeight, 'maxWeight' : maxWeight,'minVolume' : minVolume, 'maxVolume' : maxVolume,'image' : image.toJson(),'_id' : id,'deliveryCharges' : deliveryCharges,};
// }