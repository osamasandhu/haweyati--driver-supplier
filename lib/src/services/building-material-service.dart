import 'package:haweyati_supplier_driver_app/model/building-material-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class BuildingMaterialCategoriesService extends HaweyatiService<BuildingMaterialModel> {
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
