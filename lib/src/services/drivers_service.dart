import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class DriverService extends HaweyatiService<Driver> {
  @override Driver parse(Map<String, dynamic> data) {
    return Driver.fromJson(data);
  }

  Future<Driver> getDriver(String id){
    return this.getOne('drivers/$id');
  }

  Future<Driver> getDriverByPerson(String id){
    return this.getOne('drivers/getbyperson/$id');
  }

  Future<List<Driver>> getDriversBySupplier(){
    return this.getAll('drivers/supplier/${AppData.supplier.id}');
  }

  // Future<List<Driver>> checkSupplierDrivers(){
  //   return this.getAll('drivers/dumpster/supplier/${AppData.supplier.id}');
  // }

}