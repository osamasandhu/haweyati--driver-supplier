import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/drivers_service.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/orders/select-driver_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/supplier-order-utils.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/raised-action-button.dart';
import 'package:haweyati_supplier_driver_app/widgits/cancel-order-supplier.dart';
import 'package:haweyati_supplier_driver_app/widgits/dispatch-order.dart';

import '../../../data.dart';

class SupplierOrderActionButton extends StatefulWidget {
  final Order order;
  SupplierOrderActionButton({@required this.order});
  @override
  _SupplierOrderActionButtonState createState() => _SupplierOrderActionButtonState();
}

class _SupplierOrderActionButtonState extends State<SupplierOrderActionButton> {
  static Order order;

  static Widget generateActionBtn(BuildContext context){
    switch(order.status){
      case OrderStatus.pending:
        return acceptOrder(context);
        break;
      case OrderStatus.preparing:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
           if(order.driver !=null)  dispatchOrder(context) else if(order.type == OrderType.dumpster) assignDriver(context),
            if(order.driver==null) cancelOrder(context),
          ],
        );
        break;
      case OrderStatus.accepted:
        return order.driver !=null && order.payment.type!=null ?
        dispatchOrder(context) : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(order.driver==null && order.type == OrderType.dumpster)  assignDriver(context),
            if(order.driver==null) cancelOrder(context),
            if(order.payment.type == null && order.driver !=null) Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text("Order is awaiting payment confirmation from customer.",style: TextStyle(
                color: Colors.red
              ),),
            )
          ],
        );
        break;
      case OrderStatus.preparing:
        return dispatchOrder(context);
        break;
      case OrderStatus.dispatched:
        return SizedBox();
        break;
      case OrderStatus.delivered:
        return  SizedBox();
        break;
      case OrderStatus.rejected:
        return  SizedBox();
        break;
      default:
        return SizedBox();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    order = widget.order;
  }


  @override
  Widget build(BuildContext context) {
    return SupplierUtils.canAcceptAllOrder(order) ?
    generateActionBtn(context) :
    SizedBox();
  }

  static Widget dispatchOrder(BuildContext context)=> FlatActionButton(
    label: "Dispatch Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () {
      CustomNavigator.navigateTo(context, DispatchOrder(order.id));
    },
  );

  static Widget acceptOrder(BuildContext context) => FlatActionButton(
    label: "Accept Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () async {
      if(order.type == OrderType.dumpster){
        openLoadingDialog(context, "Processing");
        List<Driver> drivers = await DriverService().getDriversBySupplier();
        if(drivers.isEmpty){
          Navigator.pop(context);
          openMessageDialog(context, "You don't have any driver linked to your supplier account, therefore you cannot accept the order.");
          return;
        } else {
          Navigator.pop(context);
        }
      }
      openLoadingDialog(context, "Accepting Order");
      await HaweyatiService.patch("orders/add-supplier-all", {
        'supplier': AppData.supplier.toJson(),
        '_id': order.id,
        'flag': true,
      });
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  static Widget cancelOrder(BuildContext context) => RaisedActionButton(
    padding: EdgeInsets.all(0),
    label: "Cancel Order",
    icon: Icon(CupertinoIcons.clear_circled_solid),
    onPressed: () async {
      String reason = await showDialog(context: context,builder: (context){
        return CancelOrderSupplier();
      });
      if(reason==null){
        return;
      }
      openLoadingDialog(context, "Cancelling Order");
      await HaweyatiService.patch("orders/add-supplier-all", {
        'supplier': AppData.supplier.toJson(),
        '_id': order.id,
        'flag': false,
        'reason' : reason
      });
      Navigator.pop(context);
      Navigator.pop(context);
    },
  );

  static Widget assignDriver(BuildContext context) => RaisedActionButton(
    label: "Assign Driver",
    padding: EdgeInsets.only(top: 0),
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () async {
      Driver _driver = await CustomNavigator.navigateTo(context, SelectDriverPage());
      if(_driver!=null){
        openLoadingDialog(context, "Assigning Order");
        var res = await HaweyatiService.patch('orders/add-driver', {
          'driver' : _driver.serialize(),
          '_id' :  order.id,
          'flag' : true
        });
        openMessageDialog(context, "Order assigned successfully");
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      }

    },
  );
}
