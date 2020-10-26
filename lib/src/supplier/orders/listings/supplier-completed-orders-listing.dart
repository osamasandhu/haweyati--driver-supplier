import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';

class SupplierCompletedOrdersListing extends StatefulWidget {
  @override
  _SupplierCompletedOrdersListingState createState() => _SupplierCompletedOrdersListingState();
}

class _SupplierCompletedOrdersListingState extends State<SupplierCompletedOrdersListing> {

  Future<List<Order>> orders;
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4),(){
      print("loading again");
      _key.currentState.loadDataAgain();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LiveScrollableView<Order>(
      key: _key,
      loadingMessage: 'Loading Completed Orders',
      loader: ()=> OrdersService().supplierCompletedOrders(),
      builder: (context,data){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: OrderTile(
            order: data,
          ),
        );
      },
    );
  }
}