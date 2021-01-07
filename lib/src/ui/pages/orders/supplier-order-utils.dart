import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';

abstract class SupplierUtils {

  static bool canAcceptAllOrder (Order order) {
    if (order.type != OrderType.finishingMaterial)
      return true;
    else
    if(order.items.length == 1 || orderTime(order) <=30 )
      return true;
    else
      return false;
  }

  static int orderTime (Order order) {
    return DateTime.now().difference(order.createdAt).inMinutes;
  }

}