import 'package:haweyati_supplier_driver_app/src/models/image_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/rent_model.dart';
import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 20)
class Dumpster extends Orderable {
  @HiveField(0) String id;
  @HiveField(1) String size;
  @HiveField(2) ImageModel image;
  @HiveField(3) List<Rent> pricing;
  @HiveField(4) String description;

  List<String> suppliers;

  Dumpster({
    this.id,
    this.size,
    this.image,
    this.pricing,
    this.suppliers,
    this.description
  });

  int get days => pricing.first.days;
  double get rent => pricing.first.rent;
  double get extraDayRent => pricing.first.extraDayRent ?? 0;

  Dumpster.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    size = json['size'];
    suppliers = json['suppliers'].cast<String>();
    description = json['description'];
    image = ImageModel.fromJson(json['image']);

    final _pricing = json['pricing'];
    if (_pricing != null) {
      if (_pricing is List) {
        pricing = _pricing
          .map((e) => Rent.fromJson(e))
          .toList(growable: false);
      } else {
        pricing = [Rent.fromJson(json['pricing'])];
      }
    }
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'size': size,
    'suppliers': suppliers,
    'description': description,
    'image': image.serialize(),
    'pricing': pricing.map((e) => e.toJson()).toList()[0]
  };

  @override serialize() => toJson();
}