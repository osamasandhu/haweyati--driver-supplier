import 'package:haweyati_supplier_driver_app/model/models/finishing-material_category.dart';
import 'haweyati-service.dart';

class FinishingMaterialService extends HaweyatiService<FinishingMaterialCategory> {
  @override
  FinishingMaterialCategory parse(Map<String, dynamic> item) => FinishingMaterialCategory.fromJson(item);

  Future<List<FinishingMaterialCategory>> getFinishingMaterial() {
    return this.getAll('finishing-material-category');
  }

}