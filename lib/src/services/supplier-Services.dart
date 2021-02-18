import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import '../data.dart';

class SupplierServices extends HaweyatiService<SupplierModel> {
  @override
  SupplierModel parse(Map<String, dynamic> json) {
    return SupplierModel.fromJson(json);
  }

  Future<List<SupplierModel>> getSupplier() {
    return this.getAll("suppliers");
  }

  Future<SupplierModel> supplierProfile(String id){
    return this.getOne("suppliers/getbyprofile/$id");
  }

  Future<SupplierModel> refreshSupplier() async {
    SupplierModel driver = await this.getOne('suppliers/${AppData.supplier.id}');
    await AppData.signIn(driver);
  }

}
