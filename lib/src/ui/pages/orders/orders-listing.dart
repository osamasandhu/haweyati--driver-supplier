import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';

class OrdersListing extends StatefulWidget {
  final Future<List<Order>> future;
  final String loadingMessage;
  OrdersListing({this.future,this.loadingMessage});

  @override
  _OrdersListingState createState() => _OrdersListingState();
}

class _OrdersListingState extends State<OrdersListing> {
  final GlobalKey<LiveScrollableViewState> _key = GlobalKey<LiveScrollableViewState>();

  Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    return LiveScrollableView<Order>(
      key: _key,
      loadingMessage: widget.loadingMessage ?? 'Loading Available Orders',
      loader: ()=> widget.future,
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