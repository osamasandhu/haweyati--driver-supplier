import 'package:hive/hive.dart';
part 'options_model.g.dart';

@HiveType(typeId: 17)
class ProductOption extends HiveObject{
  @HiveField(0)
  String sId;
  @HiveField(1)
  String optionName;
  @HiveField(2)
  String optionValues;

  ProductOption({this.sId,this.optionValues, this.optionName});

  ProductOption.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    optionName = json['optionName'];
    optionValues = json['optionValues'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['optionName'] = this.optionName;
    data['optionValues'] = this.optionValues;
    return data;
  }

}