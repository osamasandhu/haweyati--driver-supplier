import 'package:haweyati_supplier_driver_app/model/dumpster-Model.dart';
import 'package:haweyati_supplier_driver_app/model/profileModel.dart';
import 'package:haweyati_supplier_driver_app/model/supplier-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';

class ProfileServices extends HaweyatiSupplierDriverService<ProfileModel> {
  @override
  ProfileModel parse(Map<String, dynamic> json) {
    return ProfileModel.fromJson(json);
  }

  Future<List<ProfileModel>> getProfile() {
    return this.getAll("auth/profile");
  }






}
