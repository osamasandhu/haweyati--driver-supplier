import 'package:haweyati_supplier_driver_app/model/json_serializable.dart';
import 'package:hive/hive.dart';
part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel extends HiveObject implements JsonSerializable{
  @HiveField(0)
  String name;
  ImageModel({this.name});

  ImageModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = Map<String,dynamic>();
    map['name'] = name;
    return map;
  }

  @override
  Map<String, dynamic> serialize() => { 'name': name };

}
