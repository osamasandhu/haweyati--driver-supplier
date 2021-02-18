import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';

abstract class SupplierUtils {
  static bool hasAcceptedFinishingItems (Order order) => order.type == OrderType.finishingMaterial ? order.items.any((e) => (e.item as FinishingMaterialOrderItem).selected == true) : false;
}