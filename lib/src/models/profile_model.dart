import 'package:haweyati_supplier_driver_app/model/json_serializable.dart';
import 'package:hive/hive.dart';

import 'image_model.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 101)
class Profile extends HiveObject implements JsonSerializable {
  @HiveField(0) String id;
  @HiveField(1) String name;
  @HiveField(2) String email;
  @HiveField(3) String contact;
  @HiveField(4) String username;
  @HiveField(5) String password;

  @HiveField(6) bool isVerified;
  @HiveField(7) ImageModel image;

  @HiveField(8) List<String> scope;
  @HiveField(9) String token;

  Profile({
    this.id,
    this.name,
    this.image,
    this.scope,
    this.email,
    this.contact,
    this.username,
    this.password,
    this.isVerified,
  });

  factory Profile.fromJson(Map<String,dynamic> json){
    return Profile(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      image: json['image'] != null
        ? ImageModel.fromJson(json['image'])
        : null,
      contact: json['contact'],
      password: json['password'],
      username: json['username'],
      isVerified: json['isVerified'],
      scope: json['scope'].cast<String>()
    );
  }

  @override
  Map<String, dynamic> serialize() => {
    '_id': id,
    'name': name,
    'email': email,
    'scope': scope,
    'token': token,
    // 'image': image?.serialize(),
    'contact': contact,
    'username': username,
    'password': password,
    'isVerified': isVerified,
  };
}
