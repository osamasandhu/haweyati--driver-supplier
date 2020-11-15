import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/driver-supplier-map.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/building-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/dumpster/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/my-orders_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/order-mutual-widgets.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
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
        bottom:  order.status == OrderStatus.accepted ? RaisedActionButton(
          label: lang.acceptOrder,
          onPressed: () async {
            bool confirm =  await showDialog(context: context,
                builder: (context){
                  return ConfirmationDialog(title: Text(lang.sureAcceptOrder),
                  );
                });
            if(confirm!=null && confirm){
              openLoadingDialog(context, lang.acceptingOrder);
              var res = await HaweyatiService.patch('orders/add-driver', {
                'driver' : AppData.driver.serialize(),
                '_id' :order.id,
                'flag' : true
              });
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
        ) : order.status == OrderStatus.dispatched ?  RaisedActionButton(
          label: lang.markCompleted,
          onPressed: () async {
           CustomNavigator.navigateTo(context, MarkOrderCompleted(orderId: order.id,));
          },
        ) : SizedBox(),
          showBackground: true,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          appBar: HaweyatiAppBar(actions: [],),
          children: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
              sliver: SliverToBoxAdapter(child: Center(child: SizedBox(
                  width: 384,
                  child: OrderDetailHeader(order.status.index))
              )),
            ),
            SliverToBoxAdapter(child: OrderMeta(order)),

            SliverPadding(
              padding: const EdgeInsets.only(bottom: 15, top: 25),
              sliver: SliverToBoxAdapter(child: LocationPicker(initialValue: order.location,edit: false,)),
            ),

            SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) =>_OrderItemWidget(order.items[index]),
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
                  order.payment.type == 'COD' ?
                  TableRow(children: [
                    Text(lang.deliveryFee, style: TextStyle(
                      height: 2, fontSize: 13,
                      fontFamily: 'Lato',
                      color: Colors.grey.shade600,
                    )),

                    RichPriceText(price: order.deliveryFee, fontSize: 13)
                  ]) : SizedBox()
                ],
              ),
            ),
            SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Table(children: [
                    order.payment.type == 'COD' ?   TableRow(children: [
                      Text(lang.total, style: TextStyle(
                        height: 2,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: Colors.grey.shade600,
                      )),

                      RichPriceText(price: order.total, fontWeight: FontWeight.bold, fontSize: 18)
                    ]) : SizedBox()
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
                  Table(children: [
                    TableRow(children: [
                      Text(lang.paymentType, style: TextStyle(
                        height: 2,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: Colors.grey.shade600,
                      )),

                      Text(order.payment.type, textAlign: TextAlign.right, style: TextStyle(
                          fontSize: 13
                      ))                    ])
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
                ],
              ),
            ),

          ]
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  final OrderItemHolder holder;
  _OrderItemWidget(this.holder);

  @override
  Widget build(BuildContext context) {
    final qty = _qty(holder);

    return LocalizedView(
      builder: (context,lang) =>
       DarkContainer(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 35),
        child: Column(children: [
          OrderItemTile(holder),

          if (holder.item is FinishingMaterialOrderItem)
            Table(children: [
              ..._buildVariants((holder.item as FinishingMaterialOrderItem).variants),

              TableRow(children: [
                Text(lang.quantity, style: TextStyle(
                  height: 1.6,
                  fontSize: 13,
                  color: Colors.grey,
                )),

                Text('${(holder.item as FinishingMaterialOrderItem).qty} ${(holder.item as FinishingMaterialOrderItem).qty == 1 ? 'Piece' : 'Pieces'}',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Color(0xFF313F53)),
                )
              ]),
              // TableRow(children: [
              //   Text(lang.price, style: TextStyle(
              //     height: 1.6,
              //     fontSize: 13,
              //     color: Colors.grey,
              //   )),
              //
              //   RichPriceText(price: (holder.item as FinishingMaterialOrderItem).price)
              // ]),
              TableRow(children: [
                Text(lang.total, style: TextStyle(
                  height: 2.5,
                  fontSize: 13,
                  color: Colors.grey,
                )),

                RichPriceText(price: holder.subtotal, fontWeight: FontWeight.bold)

              ])
            ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline)
          else
            Table(children: [
              TableRow(children: [
                Text(lang.quantity, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 2)),
                Text(AppLocalizations.of(context).nProducts(qty), textAlign: TextAlign.right, style: TextStyle(
                    fontSize: 13
                ))
              ]),
              // TableRow(children: [
              //   Text(lang.price, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 2)),
              //   RichPriceText(price: holder.subtotal / qty, fontSize: 13)
              // ]),

              // TableRow(children: [
              //   Text(lang.total, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 3)),
              //   RichPriceText(price: holder.subtotal, fontWeight: FontWeight.bold)
              // ]),
            ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline)
        ]),

      ),
    );
  }

  static int _qty(OrderItemHolder holder) {
    if (holder.item is BuildingMaterialOrderItem) {
      return (holder.item as BuildingMaterialOrderItem).qty;
    }

    return 1;
  }
}

class OrderItemTile extends StatelessWidget {
  final OrderItemHolder item;
  OrderItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    String title;
    String imageUrl;
    dynamic product = item.item.product;

    if (item.item is DumpsterOrderItem) {
      title = '${product.size} Yards';
      imageUrl = product.image.name;
    } else if (item.item is BuildingMaterialOrderItem) {
      title = product.name;
      imageUrl = product.image.name;
    } else if (item.item is FinishingMaterialOrderItem) {
      title = product.name;
      imageUrl = product.images.name;
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 15),
      leading: Container(
        width: 60,
        decoration: BoxDecoration(
            color: Color(0xEEFFFFFF),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.grey.shade500
              )
            ],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(HaweyatiService.resolveImage(imageUrl))
            )
        ),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
_buildVariants(Map<String, dynamic> variants) {
  final list = [];

  variants?.forEach((key, value) {
    list.add(TableRow(children: [
      Text(key, style: TextStyle(
        height: 1.6,
        fontSize: 13,
        color: Colors.grey,
      )),

      Text(value, style: TextStyle(color: Color(0xFF313F53)), textAlign: TextAlign.right)
    ]));
  });

  return list;
}

class DriverBottomWidget extends StatefulWidget {
  final Order order;
  DriverBottomWidget({this.order});
  @override
  _DriverBottomWidgetState createState() => _DriverBottomWidgetState();
}

class _DriverBottomWidgetState extends State<DriverBottomWidget> {
  bool completed = false;
  bool accepted = false;



  @override
  Widget build(BuildContext context) {
    return widget.order.status == OrderStatus.accepted && !accepted ? RaisedActionButton(
      label: "Accept Order",
      onPressed: () async {
        bool confirm =  await showDialog(context: context,
            builder: (context){
              return ConfirmationDialog(title: Text('Are you sure you want to accept this order?'),
              );
            });
        if(confirm!=null && confirm){
          openLoadingDialog(context, "Accepting order");
          var res = await HaweyatiService.patch('orders/add-driver', {
            'driver' : AppData.driver.serialize(),
            '_id' :widget.order.id,
            'flag' : true
          });
          // Navigator.pop(context);
          Navigator.pop(context);
          setState(() {
            accepted=true;
          });
        }
      },
    ) : widget.order.status == OrderStatus.dispatched ?  RaisedActionButton(
      label: "Mark as Completed",
      onPressed: () async {
        CustomNavigator.navigateTo(context, MarkOrderCompleted(orderId: widget.order.id,));
      },
    ) : SizedBox();
  }
}
