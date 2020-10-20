import 'package:haweyati_supplier_driver_app/model/scaffolding-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class ScaffoldingServices extends HaweyatiService<ScaffoldingModel> {
  @override
  ScaffoldingModel parse(Map<String, dynamic> json) {
    return ScaffoldingModel.fromJson(json);
  }

  Future<List<ScaffoldingModel>> getScaffolding() {
    return this.getAll("scaffoldings");
  }

}
