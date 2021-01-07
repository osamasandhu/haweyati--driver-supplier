import 'package:haweyati_supplier_driver_app/src/models/order/scaffoldings/single-scaffolding/single-scaffolding_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class SingleScaffoldingService extends HaweyatiService<SingleScaffolding> {
  @override
  SingleScaffolding parse(Map<String, dynamic> json) {
    return SingleScaffolding.fromJson(json);
  }

  Future<List<SingleScaffolding>> vehicleTypes() {
    return this.getAll("vehicle-type");
  }

}
