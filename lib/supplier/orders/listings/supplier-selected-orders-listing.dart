import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';

class SupplierSelectedOrdersListing extends StatefulWidget {
  @override
  _SupplierSelectedOrdersListingState createState() => _SupplierSelectedOrdersListingState();
}

class _SupplierSelectedOrdersListingState extends State<SupplierSelectedOrdersListing> {

  Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = OrdersService().supplierSelectedOrders();
    orders.then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder.simplerSliver(
      context: context,
      future: orders,
      builder: (List<Order> orders){
        return SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: OrderTile(
                  order: orders[index],
                ),
              );
            },
            childCount: orders.length
        ));
      },
    );
  }
}