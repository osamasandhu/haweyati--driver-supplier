import 'package:hive/hive.dart';
part 'bm-price.g.dart';

@HiveType(typeId: 14)
class BMPrice extends HiveObject {
  String id;
  String unit;
  double price;

  BMPrice({this.id,this.price,this.unit});

  BMPrice.fromJson(Map<String,dynamic> json){
    id = json['_id'];
    unit = json['unit'];
    price = double.tryParse(json['price'].toString() ?? 0.0);
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> map = Map<String,dynamic>();
    map['_id'] = this.id;
    map['unit'] = this.unit;
    map['price'] = this.price;
    return map;
  }
}
