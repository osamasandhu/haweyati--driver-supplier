import 'package:haweyati_supplier_driver_app/model/common/location_model.dart';
import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:hive/hive.dart';
part 'supplier_model.g.dart';

@HiveType(typeId: 2)
class SupplierModel extends HiveObject {
  @HiveField(0) String sId;
  @HiveField(1) String city;
  @HiveField(2) String status;
  @HiveField(3) HiveLocation location;
  @HiveField(4) PersonModel person;
  @HiveField(5) String shopParentId;
  @HiveField(6) List<String> services;
  @HiveField(7) String message;

  SupplierModel({
    this.services,
    this.person,
    this.city,
    this.location,
    this.sId,
    this.shopParentId,
    this.message,
    this.status,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    services = json['services'].cast<String>();
    sId = json['_id'];
    person = json['person'] != null ? PersonModel.fromJson(json['person']) : null;
    status = json['status'];
    city = json['city'];
    message = json['message'];
    location = json['location'] != null ? HiveLocation.fromJson(json['location']) : null;
    shopParentId = json['parent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    data['_id'] = this.sId;
    data['status'] = this.status;
    data['city'] = this.city;
    if(this.person!=null){
      data['person'] = this.person.toJson();
    }
    if(this.shopParentId !=null){
      data['parent'] = this.shopParentId;
    }
    data['location'] = this.location.toJson();
    data['message'] = this.message;
    return data;
  }
}
