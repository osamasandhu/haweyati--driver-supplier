import 'package:haweyati_supplier_driver_app/model/common/image_model.dart';
import 'package:hive/hive.dart';
import '../../order-item_model.dart';
import 'options_model.dart';
part 'model.g.dart';

@HiveType(typeId: 22)
class FinishingMaterial extends Orderable {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) double price;
  @HiveField(3) String parent;
  @HiveField(4) ImageModel images;
  @HiveField(5) String description;
  @HiveField(6) List<Map<String, dynamic>> variants;
  @HiveField(7) List<FinishingMaterialOption> options;

  FinishingMaterial({
    this.id,
    this.name,
    this.price,
    this.parent,
    this.images,
    this.options,
    this.variants,
    this.description,
  });

  double variantPrice(Map<String, dynamic> variant) {
    for (final _variant in this.variants) {
      var flag = true;

      for (final key in _variant.keys) {
        if (key == 'price') continue;
        if (variant[key] != _variant[key]) {
          flag = false;
          break;
        }
      }

      if (flag) return double.tryParse(_variant['price'])
          ?? int.tryParse(_variant['price']).toDouble() ?? 0.0;
    }

    return 0.0;
  }

  factory FinishingMaterial.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return FinishingMaterial(
      id: json['_id'],
      name: json['name'],
      price: json['price']?.toDouble(),
      parent: json['parent'],
      description: json['description'],
      options: json['options']
          ?.map((item) => FinishingMaterialOption.fromJson(item))
          ?.toList()?.cast<FinishingMaterialOption>(),

      variants: json['varient']?.cast<Map<String, dynamic>>(),
      images: ImageModel.fromJson(json['image'])
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': this.id,
    'name': this.name,
    'image': this.images?.serialize(),
    'parent': this.parent,
    'varient': this.variants,
    'options': this.options?.map((v) => v.toJson())?.toList(),
    'description': this.description,
  };

  @override Map<String, dynamic> serialize() => toJson();
}
