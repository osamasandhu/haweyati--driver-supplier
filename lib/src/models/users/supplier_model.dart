import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:hive/hive.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
part 'supplier_model.g.dart';

@HiveType(typeId: 2)
class SupplierModel extends HiveObject {
  @HiveField(0) String id;
  @HiveField(1) String city;
  @HiveField(2) String status;
  @HiveField(3) Location location;
  @HiveField(4) Profile person;
  @HiveField(5) String shopParentId;
  @HiveField(6) List<String> services;
  @HiveField(7) String message;

  SupplierModel({
    this.services,
    this.person,
    this.city,
    this.location,
    this.id,
    this.shopParentId,
    this.message,
    this.status,
  });

  SupplierModel.fromJson(Map<String, dynamic> json) {
    print("writing json $json");
    print("writing city ${json['city']}");
    services = json['services'].cast<String>();
    id = json['_id'];
    person = json['person'] != null ? Profile.fromJson(json['person']) : null;
    status = json['status'];
    city = json['city'];
    message = json['message'];
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    shopParentId = json['parent'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    data['_id'] = this.id;
    data['status'] = this.status;
    data['city'] = this.city;
    if(this.person!=null){
      data['person'] = this.person.serialize();
    }
    if(this.shopParentId !=null){
      data['parent'] = this.shopParentId;
    }
    data['location'] = this.location.toJson();
    data['message'] = this.message;
    return data;
  }
}
