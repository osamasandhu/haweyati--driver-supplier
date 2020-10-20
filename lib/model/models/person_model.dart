
import 'package:hive/hive.dart';
part 'person_model.g.dart';

@HiveType(typeId: 12)
class Person extends HiveObject{
  @HiveField(0)
  String sId;
  @HiveField(1)
  String username;
  @HiveField(2)
  String password;
  @HiveField(3)
  String name;
  @HiveField(4)
  String type;
  @HiveField(5)
  String email;
  @HiveField(6)
  String contact;

  Person({this.username,this.password, this.name,this.type,this.email,this.contact,this.sId});

  Person.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    password = json['password'];
    type = json['type'];
    email = json['email'];
    contact = json['contact'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['password'] = this.password;
    data['name'] = this.name;
    data['type'] = this.type;
    data['email'] = this.email;
    data['contact'] = this.contact;
    return data;
  }
}