import 'package:haweyati_supplier_driver_app/model/finishing-material-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class FinishingMaterialSerivce extends HaweyatiService<FinishingMaterialModel>{
  @override
  FinishingMaterialModel parse(Map<String, dynamic> json) {
return FinishingMaterialModel.fromJson(json);
  }

  Future<List<FinishingMaterialModel>> getFishingMaterial() {
    return this.getAll("finishing-material-category");
  }

  Future<List<FinishingMaterialModel>> getFinishings(String id ) {
    return this.getAll("finishing-materials/getbyparent/$id");
  }
}