import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/driver-supplier-map.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/building-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/delivery-vehicle/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/dumpster/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/scaffoldings/single-scaffolding/single-scaffolding_orderable.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/my-orders_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/order-mutual-widgets.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/raised-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/rich-price-text.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/mark-order-complete.dart';
import 'package:haweyati_supplier_driver_app/widgits/order-location-picker.dart';


class DriverOrderDetailPage extends StatelessWidget {
  final Order order;
  DriverOrderDetailPage(this.order);

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       ScrollableView.sliver(
        fab: FloatingActionButton(
          child: Icon(Icons.map,color: Colors.white,),
          onPressed: (){

            // List<LatLng> wayPoints = [
            //   // BZ Universityersity
            //   LatLng(30.276798, 71.512020),
            //   //Chowk Kumhara
            //   LatLng(30.210255, 71.515635),
            //   //Women University
            //   LatLng(30.204883, 71.461753),
            //   //BZ University
            //   // LatLng(30.276798, 71.512020),
            // ];
            //
            // //Cant
            // LatLng destination = LatLng(30.165381, 71.386373);

            List<LatLng> wayPoints = [];

              order.items.forEach((element) {
                wayPoints.add(LatLng(element.supplier.location.latitude,element.supplier.location.longitude));
              });

            CustomNavigator.navigateTo(context, DriverRouteMapPage(
              wayPoints: wayPoints,
              destination: LatLng(order.location.latitude,order.location.longitude),
            ));
          },
        ),
        bottom: DriverBottomWidget(order: order,),
        // bottom:  order.status == OrderStatus.accepted || (order.type == OrderType.deliveryVehicle && order.status == OrderStatus.pending) ? RaisedActionButton(
        //   label: lang.acceptOrder,
        //   onPressed: () async {
        //     bool confirm =  await showDialog(context: context,
        //         builder: (context){
        //           return ConfirmationDialog(title: Text(lang.sureAcceptOrder),
        //           );
        //         });
        //     if(confirm!=null && confirm){
        //       openLoadingDialog(context, lang.acceptingOrder);
        //       var res = await HaweyatiService.patch('orders/add-driver', {
        //         'driver' : AppData.driver.serialize(),
        //         '_id' :order.id,
        //         'flag' : true
        //       });
        //       Navigator.pop(context);
        //       Navigator.pop(context);
        //     }
        //   },
        // ) : order.status == OrderStatus.dispatched || (order.type == OrderType.deliveryVehicle && order.status == OrderStatus.preparing) ? RaisedActionButton(
        //   label: lang.markCompleted,
        //   onPressed: () async {
        //    CustomNavigator.navigateTo(context, MarkOrderCompleted(orderId: order.id,));
        //   },
        // ) : SizedBox(),
          showBackground: true,
           padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          appBar: HaweyatiAppBar(actions: [],),
          children: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
              sliver: SliverToBoxAdapter(child: Center(child: SizedBox(
                  width: 360,
                  child: OrderDetailHeader(order.status.index))
              )),
            ),
            SliverToBoxAdapter(child: OrderMeta(order)),

            SliverPadding(
              padding: const EdgeInsets.only(bottom: 15, top: 25),
              sliver: SliverToBoxAdapter(child: LocationPicker(
                initialValue: order.location,edit: false,)),
            ),
           if(order.type == OrderType.deliveryVehicle) SliverPadding(
              padding: const EdgeInsets.only(bottom: 15, top: 0),
              sliver: SliverToBoxAdapter(child: LocationPicker(
                title: 'Pick Up Location',
                initialValue: (order.items.first.item as dynamic).pickUp,
                edit: false,)),
            ),
            SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) =>OrderItemWidget(order.items[index]),
                childCount: order.items.length
            )),

            SliverToBoxAdapter(
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
                children: [
                  // TableRow(children: [
                  //   Text(lang.subtotal, style: TextStyle(
                  //     height: 2, fontSize: 13,
                  //     fontFamily: 'Lato',
                  //     color: Colors.grey.shade600,
                  //   )),
                  //
                  //   RichPriceText(price: order.total - order.deliveryFee, fontSize: 13)
                  // ]),
                  if(order.payment == 'COD')
                  TableRow(children: [
                    Text(lang.deliveryFee, style: TextStyle(
                      height: 2, fontSize: 13,
                      fontFamily: 'Lato',
                      color: Colors.grey.shade600,
                    )),

                    RichPriceText(price: order.deliveryFee, fontSize: 13)
                  ])
                ],
              ),
            ),
            SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Table(children: [
                    if(order.payment == 'COD') TableRow(children: [
                      Text(lang.total, style: TextStyle(
                        height: 2,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: Colors.grey.shade600,
                      )),

                      RichPriceText(price: order.total, fontWeight: FontWeight.bold, fontSize: 18)
                    ])
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),

               if(order.payment !=null) Table(children: [
                    TableRow(children: [
                      Text(lang.paymentType, style: TextStyle(
                        height: 2,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: Colors.grey.shade600,
                      )),

                      Text(order.payment, textAlign: TextAlign.right, style: TextStyle(
                          fontSize: 13
                      ))])
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
                  SizedBox(height: 50,)
                ],
              ),
            ),

          ]
      ),
    );
  }
}


class DriverBottomWidget extends StatefulWidget {
  final Order order;
  DriverBottomWidget({this.order});
  @override
  _DriverBottomWidgetState createState() => _DriverBottomWidgetState();
}

class _DriverBottomWidgetState extends State<DriverBottomWidget> {
  static Order order;
  bool completed = false;
  bool accepted = false;

  static Widget generateActionBtn(BuildContext context){
    print(order.status);
    switch(order.status){
      case OrderStatus.pending:
        return acceptOrder(context);
        break;
      case OrderStatus.accepted:
        return acceptOrder(context);
        break;
      case OrderStatus.dispatched:
       return completeOrder(context);
        break;
      case OrderStatus.preparing:
        if(order.type == OrderType.deliveryVehicle)
         return dispatchDeliveryVehicleOrder(context);
        else
          return SizedBox();
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

  static Widget acceptOrder(BuildContext context) => FlatActionButton(
    label: "Accept Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () async {
      bool confirm =  await showDialog(context: context,
          builder: (context){
            return ConfirmationDialog(title: Text('Are you sure you want to accept this order?'),
            );
          });
      if(confirm!=null && confirm){
        openLoadingDialog(context, "Accepting order");
        var res;
        try {
          res = await HaweyatiService.patch('orders/add-driver', {
            'driver' : AppData.driver.serialize(),
            '_id' : order.id,
            'flag' : true
          });
        } catch (e){
          print(e);
          openMessageDialog(context, e.message);
         return;
        }

        Navigator.pop(context);
        Navigator.pop(context);
      }
    },
  );

  static Widget completeOrder(BuildContext context) => FlatActionButton(
    label: "Complete Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () {
      CustomNavigator.navigateTo(context, MarkOrderCompleted(orderId: order.id,));
    },
  );


  static Widget dispatchDeliveryVehicleOrder(BuildContext context) => FlatActionButton(
    label: "Dispatch Order",
    icon: Icon(CupertinoIcons.checkmark_circle),
    onPressed: () async {
        openLoadingDialog(context, "Dispatching order");
        var res = await HaweyatiService.patch('orders/update-order-status', {
          '_id' : order.id,
          'status' : OrderStatus.dispatched.index
        });
        Navigator.pop(context);
        Navigator.pop(context);
    },
  );

  @override
  Widget build(BuildContext context) {
    return generateActionBtn(context);
  }
}
