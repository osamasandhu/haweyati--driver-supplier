import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-order-detail.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/supplier-order-detail.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/timeAgoSinceDate.dart';

import 'custom-navigator.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  final Function refresh;
  OrderTile({this.order,this.refresh});

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       InkWell(
        onTap: () async {
         await CustomNavigator.navigateTo(context, AppData.isSupplier
              ? SupplierOrderDetailPage(order)
              : DriverOrderDetailPage(order));
         refresh();
          // CustomNavigator.navigateTo(context, SupplierOrderDetail(order: order,));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade200,
                spreadRadius: 1,
                blurRadius: 10
              ),
            ]
          ),
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: tileColor(order.status),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10)
                )
              ),

              child: Row(children: <Widget>[
                Text(order.number.toUpperCase(), style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )),
                SizedBox(width: 10),
                Text(timeAgoSinceDate(order.createdAt,lang), style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontStyle: FontStyle.italic
                )),
              ]),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(lang.dropOffAddress)
            ),
            SizedBox(height: 7),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CupertinoTextField(
                  readOnly: true,
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  suffix: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(Icons.map),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8)
                  ),
                  style: TextStyle(color: Colors.grey.shade600),
                  controller: TextEditingController(text: order.location.address),
                )
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Wrap(children:  <Widget>[
                Text(Order.typeToString(order.type)),
               // order.subService !=null ? Text("12 Yard Dumpster ") : SizedBox(),
              ]
              )
            ),
          ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  Color tileColor(OrderStatus status){
    switch(status){
      case OrderStatus.rejected:
        return Colors.red[300];
        break;
      case OrderStatus.pending:
        return Colors.red[300];
        break;
      case OrderStatus.accepted:
        return Colors.green;
        break;
      case OrderStatus.dispatched:
        return Colors.deepOrangeAccent;
        break;
      case OrderStatus.delivered:
        return Colors.black;
        break;
      case OrderStatus.preparing:
        return Colors.amber.shade800;
        break;
      default:
        return Colors.red[300];
    }
  }


}
