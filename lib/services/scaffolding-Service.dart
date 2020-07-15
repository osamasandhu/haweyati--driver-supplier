import 'package:haweyati_supplier_driver_app/model/dumpster-Model.dart';
import 'package:haweyati_supplier_driver_app/model/scaffolding-model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';

class ScaffoldingServices extends HaweyatiSupplierDriverService<ScaffoldingModel> {
  @override
  ScaffoldingModel parse(Map<String, dynamic> json) {
    return ScaffoldingModel.fromJson(json);
  }

  Future<List<ScaffoldingModel>> getScaffolding() {
    return this.getAll("scaffoldings");
  }

}
