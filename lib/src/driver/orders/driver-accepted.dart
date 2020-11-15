import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';

class DriverAcceptedOrdersListing extends StatefulWidget {
  @override
  _DriverAcceptedOrdersListingState createState() => _DriverAcceptedOrdersListingState();
}

class _DriverAcceptedOrdersListingState extends State<DriverAcceptedOrdersListing> {

  Future<List<Order>> orders;
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       LiveScrollableView<Order>(
        key: _key,
        loadingMessage: lang.loadingAcceptedOrders,
        loader: ()=> OrdersService().driverAcceptedOrders(),
        noDataMessage: lang.noAcceptedOrders,
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