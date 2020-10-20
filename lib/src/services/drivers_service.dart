import 'package:haweyati_supplier_driver_app/model/driver/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class DriverService extends HaweyatiService<DriverModel> {
  @override DriverModel parse(Map<String, dynamic> data) {
    return DriverModel.fromJson(data);
  }

  Future<DriverModel> getDriver(String id){
    return this.getOne('drivers/$id');
  }

  Future<DriverModel> getDriverByPerson(String id){
    return this.getOne('drivers/getbyperson/$id');
  }

}