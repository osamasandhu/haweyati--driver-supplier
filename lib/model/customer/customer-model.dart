import 'package:haweyati_supplier_driver_app/model/common/location_model.dart';
import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:hive/hive.dart';
part 'customer-model.g.dart';

@HiveType(typeId: 4)
class Customer extends HiveObject{
  @HiveField(0)
  String id;
  @HiveField(1)
  PersonModel profile;
  @HiveField(2)
  HiveLocation location;
  @HiveField(3)
  String token;
  @HiveField(4)
  String message;
  @HiveField(5)
  String status;

  Customer({this.location,this.id,this.token,this.message,this.profile,this.status});

  Customer.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['_id'];
    profile =  json['profile'] !=null ? PersonModel.fromJson(json['profile']) : null;
    token = json['token'];
    location = json['location'] !=null ? HiveLocation.fromJson(json['location']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.id;
    data['location'] = this.location?.toJson();
    data['profile'] = this.profile?.toJson();
//    data['token'] = this.token;
    data['status'] = this.token;
    data['message'] = this.message;
    return data;
  }

}