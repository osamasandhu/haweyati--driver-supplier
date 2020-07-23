
import 'package:haweyati_supplier_driver_app/model/location-Model.dart';

class SupplierModel {
  String scope;
  List<String> services;
  String sId;
  String address;
  String shopParentId;
  String name;
  String email;
  String contact;
  String status;
  String city;
  List<Images> images;
  String password;
  int iV;
  double latitude;
  double longitude;
  LocationModel locationModel;


  SupplierModel(
      {this.services,
        this.address,
        this.latitude,
        this.longitude,
        this.scope,
        this.city,
        this.password,this.locationModel
        ,this.sId,this.shopParentId
        ,this.name,
        this.email,
        this.contact,
        this.status,
        this.images,
        this.iV});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    services =
        json['services'].cast<String>();
    sId =
    json['_id'];
    address=
    json['address'];
    name = json['name'];
    email = json['email'];
    contact = json['contact'];
    status = json['status'];
    city = json['city'];
    password = json['password'];
    if (json['images'] != null) {
      images = List<Images>();
      json['images'].forEach((v) {
        images.add(Images.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['services'] = this.services;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['latitude']=this.latitude.toString();
    data['longitude']=this.longitude.toString();
    data['address']=this.address;
    data['contact'] = this.contact;
    data['scope'] = this.scope;
    data['status'] = this.status;
    data['city'] = this.city;
    data['password']=this.password;
    data['parent'] = this.shopParentId;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.locationModel != null) {
      data['location'] = this.locationModel.toJson();
    }
    return data;
  }
}

class Images {
  String sId;
  String name;
  String path;

  Images({this.sId, this.name, this.path});

  Images.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}