import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/timeAgoSinceDate.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
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
              color: Colors.red[300],
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
              Text(timeAgoSinceDate(order.createdAt.toIso8601String()), style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontStyle: FontStyle.italic
              )),
            ]),
          ),
          // SizedBox(height: 15,),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Text("Pick-up Address"),
//         ),
//         SizedBox(height: 7),
//         Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: CupertinoTextField(
//               onTap: () {
// //              CustomNavigator.navigateTo(context, DriverViewAllOrders());
//               },
//               readOnly: true,
//               padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
//               suffix: Padding(
//                 padding: const EdgeInsets.all(8),
//                 child: Icon(Icons.map),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               style: TextStyle(color: Colors.grey.shade600),
//               controller: TextEditingController(text: order.dropOff.dropOffAddress),
//             )
//         ),
          SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Drop-off Address")
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
                // controller: TextEditingController(text: order.dropOff.dropOffAddress ?? ''),
              )
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(children:  <Widget>[
              // Text(order.service),
             // order.subService !=null ? Text("12 Yard Dumpster ") : SizedBox(),
            ]
            )
          ),
        ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
