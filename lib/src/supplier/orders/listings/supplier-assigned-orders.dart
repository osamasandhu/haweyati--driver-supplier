import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';

class SupplierAssignedOrdersListing extends StatefulWidget {
  @override
  _SupplierAssignedOrdersListingState createState() => _SupplierAssignedOrdersListingState();
}

class _SupplierAssignedOrdersListingState extends State<SupplierAssignedOrdersListing> {

  Future<List<Order>> orders;
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  void initState() {
    super.initState();
    // orders = OrdersService().supplierSelectedOrders();
    // orders.then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
          LiveScrollableView<Order>(
            key: _key,
            loadingMessage: lang.loadingAcceptedOrders,
            noDataMessage: "No Assigned Orders",
            loader: ()=> OrdersService().ordersByStatus(OrderStatus.preparing),
            builder: (context,data){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: OrderTile(
                  order: data,
                  refresh: (){
                    _key.currentState.loadDataAgain();
                  },
                ),
              );
            },
          ),
    );
  }
}