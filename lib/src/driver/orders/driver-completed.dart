import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';

class DriverCompletedOrdersListing extends StatefulWidget {
  @override
  _DriverCompletedOrdersListingState createState() => _DriverCompletedOrdersListingState();
}

class _DriverCompletedOrdersListingState extends State<DriverCompletedOrdersListing> {

  Future<List<Order>> orders;
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       LiveScrollableView<Order>(
        key: _key,
        loadingMessage: lang.loadingCompletedOrders,
        loader: ()=> OrdersService().driverCompletedOrders(),
        noDataMessage: lang.noCompletedOrders,
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