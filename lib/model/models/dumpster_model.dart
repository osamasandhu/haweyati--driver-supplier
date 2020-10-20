import 'package:hive/hive.dart';
import 'images_model.dart';
import 'rent_model.dart';
part 'dumpster_model.g.dart';


@HiveType(typeId: 20)
class Dumpster extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  String size;
  @HiveField(2)
  String description;
  @HiveField(3)
  List<Rent> pricing;
  @HiveField(4)
  List<String> suppliers;
  @HiveField(5)
  Images image;

  Dumpster({
    this.id,
    this.size,
    this.image,
    this.pricing,
    this.suppliers,
    this.description
  });

  Dumpster.fromJson(Map<String, dynamic> json,[bool order = false]) {
    id = json['_id'];
    size = json['size'];
    suppliers = json['suppliers'].cast<String>();
    description = json['description'];
    image =  Images.fromJson(json['image']);

    if (json['pricing'] != null) {
      if(order){
        pricing = [Rent.fromJson(json['pricing'])];
      } else {
        pricing = List<Rent>();
        json['pricing'].forEach((v) {
          pricing.add( Rent.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "size": size,
    "suppliers": suppliers,
    "description": description,
    "image": image.toJson(),
    "pricing": pricing.map((e) => e.toJson()).toList()[0]
  };
}