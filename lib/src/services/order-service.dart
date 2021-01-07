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
    return this.getAll('orders/filter$services&city=${AppData.supplier.city}');
  }

  Future<List<Order>> supplierSelectedOrders() async {
    return this.getAll('orders/selected-supplier/${AppData.supplier.id}');
  }

  Future<List<Order>> ordersByStatus(OrderStatus status){
    if(AppData.isDriver){
      return this.getAll('orders/driver-status/${AppData.driver.sId}/${status.index}');
    } else {
      return this.getAll('orders/supplier-status/${AppData.supplier.id}/${status.index}');
    }
  }

  Future<List<Order>> supplierAssignedOrders() async {
    return this.getAll('orders/assigned-supplier/${AppData.supplier.id}');
  }

  Future<List<Order>> supplierCompletedOrders() async {
    return this.getAll('orders/completed-supplier/${AppData.supplier.id}');
  }

  Future<List<Order>> supplierDispatchedOrders() async {
    return this.getAll('orders/dispatched-supplier/${AppData.supplier.id}');
  }

  Future<List<Order>> driverAllOrders() async {
    return this.getAll('orders/driver/new/${AppData.driver.city}');
  }

  Future<List<Order>> driverDispatchedOrders() async {
    return this.getAll('orders/dispatched-driver/${AppData.driver.sId}');
  }

  Future<List<Order>> driverAcceptedOrders() async {
    return this.getAll('orders/preparing-driver/${AppData.driver.sId}');
  }

  Future<List<Order>> driverCompletedOrders() async {
    return this.getAll('orders/completed-driver/${AppData.driver.sId}');
  }

}