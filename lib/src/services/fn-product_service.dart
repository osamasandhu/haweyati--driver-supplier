import 'package:haweyati_supplier_driver_app/model/models/finishing-product.dart';
import 'haweyati-service.dart';

class FinishingMaterialProductService extends HaweyatiService<FinProduct> {
  @override
  FinProduct parse(Map<String, dynamic> item) => FinProduct.fromJson(item);

  Future<List<FinProduct>> getFinSublist(String parentId) async {
    return this.getAll('finishing-materials?parent=$parentId');
  }

  Future<List<FinProduct>> search(String keyword) async {
    return this.getAll('finishing-materials/search?name=$keyword');
  }

}