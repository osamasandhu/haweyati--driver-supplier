import 'package:haweyati_supplier_driver_app/model/dumpster-Model.dart';
import 'package:haweyati_supplier_driver_app/model/supplier-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';

class DumpsterServices extends HaweyatiSupplierDriverService<DumspterModel> {
  @override
  DumspterModel parse(Map<String, dynamic> json) {
    return DumspterModel.fromJson(json);
  }

  Future<List<DumspterModel>> getDumpster() {
    return this.getAll("dumpsters");
  }

}
