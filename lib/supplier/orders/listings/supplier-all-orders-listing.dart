import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
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
    orders = OrdersService().supplierAllOrders();
    debug(orders);
  }

  debug(dynamic value) {
    value.then((val)=> print(val[0]));
  }

  @override
  Widget build(BuildContext context) {
    return LiveScrollableView<Order>(
      title: '',
      subtitle: '',
      loader: ()=> orders,
      builder: (context,data){
        return Padding(
          padding: const EdgeInsets.all(10),
          child: OrderTile(
            order: data,
          ),
        );
      },
    );
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