import 'package:haweyati_client_data_models/models/image_model.dart';

class FinishingMaterialCategory {
  String id;
  String name;
  ImageModel image;
  String description;

  FinishingMaterialCategory({
    this.id,
    this.name,
    this.image,
    this.description,
  });

  FinishingMaterialCategory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    image = ImageModel.fromJson(json['image']);
  }
}