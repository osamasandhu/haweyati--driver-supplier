import 'package:haweyati_supplier_driver_app/src/models/services/dumpster/model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';

class DumpsterServices extends HaweyatiService<Dumpster> {
  @override
  Dumpster parse(Map<String, dynamic> json) {
    return Dumpster.fromJson(json);
  }

  Future<List<Dumpster>> getDumpster() {
    return this.getAll("dumpsters");
  }

}
