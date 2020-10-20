import 'package:hive/hive.dart';
part 'bm-pricing.g.dart';

@HiveType(typeId: 15)
class BMPricing extends HiveObject{
  @HiveField(0)
  String city;
  @HiveField(1)
  double price20yard;
  @HiveField(2)
  double price12yard;
  @HiveField(3)
  String sId;

  BMPricing({this.price12yard,this.price20yard, this.city});

  BMPricing.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    price12yard = double.parse(json['price12yard'].toString());
    price20yard = double.parse(json['price20yard'].toString());
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['price12yard'] = this.price12yard;
    data['price20yard'] = this.price20yard;
    return data;
  }
}
