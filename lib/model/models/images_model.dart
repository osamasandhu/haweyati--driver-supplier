import 'package:hive/hive.dart';
part 'images_model.g.dart';


@HiveType(typeId: 13)
class Images extends HiveObject {
  @HiveField(0)
  String sId;
  @HiveField(1)
  String path;
  @HiveField(2)
  String name;

  Images({this.sId, this.path,this.name});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    path = json['path'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['path'] = this.path;
    data['name'] = this.name;
    return data;
  }
}