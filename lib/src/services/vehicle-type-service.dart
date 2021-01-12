import 'package:haweyati_client_data_models/models/order/vehicle-type.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class VehicleTypesService extends HaweyatiService<VehicleType> {
  @override
  VehicleType parse(Map<String, dynamic> json) {
    return VehicleType.fromJson(json);
  }

  Future<List<VehicleType>> vehicleTypes() {
    return this.getAll("vehicle-type");
  }

}
