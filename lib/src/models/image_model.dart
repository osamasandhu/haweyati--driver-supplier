import 'package:haweyati_supplier_driver_app/model/json_serializable.dart';
import 'package:hive/hive.dart';

part 'image_model.g.dart';

@HiveType(typeId: 102)
class ImageModel extends HiveObject implements JsonSerializable {
  @HiveField(0) String name;

  ImageModel({this.name});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(name: json['name']);
  }

  @override
  Map<String, dynamic> serialize() => { 'name': name };
}