import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';

class DriverPendingOrdersListing extends StatefulWidget {
  @override
  _DriverPendingOrdersListingState createState() => _DriverPendingOrdersListingState();
}

class _DriverPendingOrdersListingState extends State<DriverPendingOrdersListing> {

  Future<List<Order>> orders;
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  Widget build(BuildContext context) {
    return LiveScrollableView<Order>(
      key: _key,
      loadingMessage: 'Loading Available Orders',
      loader: ()=> OrdersService().driverAllOrders(),
      noDataMessage: 'No Available Orders',
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