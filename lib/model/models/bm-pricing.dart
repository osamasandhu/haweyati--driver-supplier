import 'package:hive/hive.dart';
part 'bm-pricing.g.dart';

@HiveType(typeId: 15)
class BMPricing extends HiveObject{
  @HiveField(0)
  String city;
  @HiveField(3)
  String sId;

  BMPricing({ this.city});

  BMPricing.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['_id'] = this.sId;
    return data;
  }
}
