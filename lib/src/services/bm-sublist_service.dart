import 'package:haweyati_supplier_driver_app/model/models/building-material_sublist.dart';
import 'haweyati-service.dart';

class BMSublistService extends HaweyatiService<BMProduct> {
  @override
  BMProduct parse(Map<String, dynamic> item) => BMProduct.fromJson(item);

  Future<List<BMProduct>> getBMSublist(String parentId) async {
    return this.getAll('building-materials?parent=$parentId');
  }

}