import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/model/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/order-tile.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';

class SupplierAllOrdersListing extends StatefulWidget {
  @override
  _SupplierAllOrdersListingState createState() => _SupplierAllOrdersListingState();
}

class _SupplierAllOrdersListingState extends State<SupplierAllOrdersListing> {

  Future<List<Order>> orders;

  @override
  void initState() {
    super.initState();
    orders = OrdersService().orders();
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