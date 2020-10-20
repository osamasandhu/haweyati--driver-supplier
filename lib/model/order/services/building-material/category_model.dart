import 'package:haweyati_supplier_driver_app/model/common/image_model.dart';

class BuildingMaterialCategory {
  String id;
  String name;
  ImageModel image;
  String description;

  BuildingMaterialCategory({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  BuildingMaterialCategory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    image = ImageModel.fromJson(json['image']);
  }
}