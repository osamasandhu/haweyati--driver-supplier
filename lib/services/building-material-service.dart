import 'package:haweyati_supplier_driver_app/model/building-material-Model.dart';
import 'package:haweyati_supplier_driver_app/model/dumpster-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';

class BuildingMaterialServices extends HaweyatiSupplierDriverService<BuildingMaterialModel> {
  @override
  BuildingMaterialModel parse(Map<String, dynamic> json) {
    return BuildingMaterialModel.fromJson(json);
  }

  Future<List<BuildingMaterialModel>> getBuildingMaterial() {
    return this.getAll("building-material-category");


  }

  Future<List<BuildingMaterialModel>> getProdcuts(String id ) {
    return this.getAll("building-materials/getbyparent/$id");


  }


}
