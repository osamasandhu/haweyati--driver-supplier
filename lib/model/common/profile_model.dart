import 'package:hive/hive.dart';
import 'image_model.dart';
part 'profile_model.g.dart';

@HiveType(typeId: 3)
class PersonModel extends HiveObject{
  @HiveField(0) String id;
  @HiveField(2) String name;
  @HiveField(4) String email;
  @HiveField(5) String contact;
  @HiveField(6) String username;
  @HiveField(7) String password;
  @HiveField(1) ImageModel image;
  @HiveField(8) List<String> scope;

  PersonModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.scope,
    this.contact,
    this.username,
    this.password
  });

  PersonModel.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['_id'];
    name = json['name'];
    scope = json['scope'].cast<String>();
    email = json['email'];
    contact = json['contact'];
    username = json['username'];
    password = json['password'];
    image = json['image'] != null ? ImageModel.fromJson(json['image']) : null;
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic  > map = Map<String,dynamic>();
    map['name'] = this.name;
    map['_id'] = this.id;
    map['scope'] = this.scope;
    map['contact'] = this.contact;
    map['username'] = this.username;
    map['image'] = this.image?.toJson();
    return map;
  }
}