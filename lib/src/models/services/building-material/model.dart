import 'package:haweyati_client_data_models/models/image_model.dart';
import 'package:haweyati_supplier_driver_app/model/models/bm-pricing.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 21)
class BuildingMaterial extends HiveObject implements Orderable {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String parent;
  @HiveField(3) ImageModel image;
  @HiveField(4) String description;
  @HiveField(5) List<BMPricing> pricing;

  BuildingMaterial({
    this.id,
    this.name,
    this.image,
    this.parent,
    this.pricing,
    this.description,
  });

  BuildingMaterial.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    parent = json['parent'];

    if (json['pricing'] != null) {
      pricing = List<BMPricing>();

      json['pricing'].forEach((v) {
        pricing.add(BMPricing.fromJson(v));
      });
    }

    description = json['description'];
    image = ImageModel.fromJson(json['image']);
  }

  Map<String, dynamic> toJson() => {
    'name': this.name,
    'image': this.image.toJson(),
    'parent': this.parent,

    'pricing': pricing
      ?.map((e) => e.toJson())
      ?.toList(),

    'description': this.description,
  };

  @override
  Map<String, dynamic> serialize() => toJson();
}



