import 'package:haweyati_supplier_driver_app/model/supplier-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';

class SupplierServices extends HaweyatiSupplierDriverService<SupplierModel> {
  @override
  SupplierModel parse(Map<String, dynamic> json) {
    return SupplierModel.fromJson(json);
  }

  Future<List<SupplierModel>> getSupplier() {
    return this.getAll("suppliers");
  }

}
