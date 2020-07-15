import 'package:haweyati_supplier_driver_app/model/finishing-material-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';

class FinishingMaterialSerivce extends HaweyatiSupplierDriverService<FinishingMaterialModel>{
  @override
  FinishingMaterialModel parse(Map<String, dynamic> json) {
    // TODO: implement parse
return FinishingMaterialModel.fromJson(json);
  }

  Future<List<FinishingMaterialModel>> getFishingMaterial() {
    return this.getAll("finishing-material-category");
  }



  Future<List<FinishingMaterialModel>> getFinishings(String id ) {
    return this.getAll("finishing-materials/getbyparent/$id");


  }
}