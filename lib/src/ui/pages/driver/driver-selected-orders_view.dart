import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/orders/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-order-tile.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';

class DriverSelectedOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleFutureBuilder.simplerSliver(
      context: context,
      future: OrdersService().driverAllOrders(),
      builder: (List<Order> orders){
        return SliverList(delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: DriverOrderTile(
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