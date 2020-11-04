import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';

class SupplierSelectedOrdersListing extends StatefulWidget {
  @override
  _SupplierSelectedOrdersListingState createState() => _SupplierSelectedOrdersListingState();
}

class _SupplierSelectedOrdersListingState extends State<SupplierSelectedOrdersListing> {

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
    return LiveScrollableView<Order>(
      key: _key,
      loadingMessage: 'Loading Selected Orders',
      noDataMessage: 'No Selected Orders',
      loader: ()=> OrdersService().supplierSelectedOrders(),
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
    );
  }
}