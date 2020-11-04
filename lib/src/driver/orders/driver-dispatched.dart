import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';

class DriverDispatchedOrdersListing extends StatefulWidget {
  @override
  _DriverDispatchedOrdersListingState createState() => _DriverDispatchedOrdersListingState();
}

class _DriverDispatchedOrdersListingState extends State<DriverDispatchedOrdersListing> {

  Future<List<Order>> orders;
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  Widget build(BuildContext context) {
    return LiveScrollableView<Order>(
      key: _key,
      loadingMessage: 'Loading Dispatched Orders',
      loader: ()=> OrdersService().driverDispatchedOrders(),
      noDataMessage: 'No Dispatched Orders',
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