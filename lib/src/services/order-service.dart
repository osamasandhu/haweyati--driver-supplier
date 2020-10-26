import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';

class OrdersService extends HaweyatiService<Order> {
  @override
  Order parse(Map<String, dynamic> item) => Order.fromJson(item);

  Future<List<Order>> supplierAllOrders() async {
    String services = '';

    for (var i = 0; i < AppData.supplier.services.length; ++i) {
      if (services.indexOf('?') == -1) {
        services = services + '?services[]=' + AppData.supplier.services[i];
      } else {
        services = services + '&services[]=' + AppData.supplier.services[i];
      }
    }
    //Todo : Fix city bug it returns null or address instead
    return this.getAll('orders/filter$services&city=${AppData.supplier.city}');
  }

  Future<List<Order>> supplierSelectedOrders() async {
    return this.getAll('orders/selected-supplier/${AppData.supplier.sId}');
  }

  Future<List<Order>> supplierCompletedOrders() async {
    return this.getAll('orders/completed-supplier/${AppData.supplier.sId}');
  }

  Future<List<Order>> driverAllOrders() async {
    return this.getAll('orders/getactive');
  }

  Future<List<Order>> driverSelectedOrders() async {
    return this.getAll('orders/dispatched-driver/${AppData.driver.sId}');
  }

  Future<List<Order>> driverCompletedOrders() async {
    return this.getAll('orders/completed-driver/${AppData.driver.sId}');
  }

}