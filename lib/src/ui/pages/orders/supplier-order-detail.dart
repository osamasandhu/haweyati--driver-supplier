import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/building-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/dumpster/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/raised-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/rich-price-text.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/cancel-order-supplier.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/dispatch-order.dart';
import 'package:haweyati_supplier_driver_app/widgits/order-location-picker.dart';
import 'my-orders_page.dart';
import 'order-mutual-widgets.dart';


class SupplierOrderDetailPage extends StatelessWidget {
  final Order order;
  SupplierOrderDetailPage(this.order);

  @override
  Widget build(BuildContext context) {
    // print(order.toJson());
    return LocalizedView(
      builder: (context,lang) =>
      ScrollableView.sliver(
        bottom: order.status == OrderStatus.preparing ?  RaisedActionButton(
          label: "Dispatch Order",
          onPressed: () async {
            CustomNavigator.navigateTo(context, DispatchOrder(orderId: order.id,));
          },
        ) : SizedBox(),
          showBackground: true,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          appBar: HaweyatiAppBar(actions: [
            IconButton(
                icon: Image.asset(CustomerCareIcon, width: 20),
                // onPressed: () => Navigator.of(context).pushNamed(HELPLINE_PAGE)
            )
          ]),
          children: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(5, 20, 5, 40),
              sliver: SliverToBoxAdapter(child: OrderDetailHeader(order.status.index)),
            ),

            SliverToBoxAdapter(child: OrderMeta(order)),

            SliverPadding(
              padding: const EdgeInsets.only(bottom: 15, top: 25),
              sliver: SliverToBoxAdapter(child: LocationPicker(initialValue: order.location,edit: false,)),
            ),

            SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) => SupplierItemSelector(
                      index: index,
                      order: order,
                      orderId: order.id,
                      widget: OrderItemWidget(order.items[index]),
                    ),
                childCount: order.items.length
            )),

            SliverToBoxAdapter(
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
                children: [
                  TableRow(children: [
                    Text(lang.subtotal, style: TextStyle(
                      height: 2, fontSize: 13,
                      fontFamily: 'Lato',
                      color: Colors.grey.shade600,
                    )),

                    RichPriceText(price: order.total - order.deliveryFee, fontSize: 13)
                  ]),
                  // TableRow(children: [
                  //   Text(lang.deliveryFee, style: TextStyle(
                  //     height: 2, fontSize: 13,
                  //     fontFamily: 'Lato',
                  //     color: Colors.grey.shade600,
                  //   )),
                  //
                  //   RichPriceText(price: order.deliveryFee, fontSize: 13)
                  // ])
                ],
              ),
            ),
            SliverToBoxAdapter(child: Divider()),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Table(children: [
                    TableRow(children: [
                      Text(lang.total, style: TextStyle(
                        height: 2,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: Colors.grey.shade600,
                      )),

                      RichPriceText(price: order.total-order.deliveryFee, fontWeight: FontWeight.bold, fontSize: 18)
                    ])
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
                  Table(children: [
                    TableRow(children: [
                      Text("Payment Type", style: TextStyle(
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
            )
          ]
      ),
    );
  }
}




class SupplierItemSelector extends StatefulWidget {
  final String orderId;
  final int index;
  final Order order;
  final Widget widget;
  SupplierItemSelector({this.index,this.order,this.orderId,this.widget});
  @override
  _SupplierItemSelectorState createState() => _SupplierItemSelectorState();
}

class _SupplierItemSelectorState extends State<SupplierItemSelector> {

  static OrderItemHolder item;

  @override
  void initState() {
    super.initState();
    item = widget.order.items[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          widget.widget,
          if (item.supplier?.id == AppData.supplier.id )
            Transform.translate(
                offset: Offset(-55, -55),
                child: Transform.rotate(
                  angle: 225.45,
                  child: Container(
                      width: 100,
                      height: 100,
                      color: Theme.of(context).accentColor,
                      child: Align(
                        alignment: Alignment(0, .97),
                        child: Text("Accepted", style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold
                        ), textAlign: TextAlign.center),
                      )
                  ),
                )
            ),
          if (item.supplier == null || AppData.supplier.id == item.supplier?.id && widget.order.status.index !=4 &&
              (widget.order.status == OrderStatus.accepted || widget.order.status == OrderStatus.approved) )
            Positioned(
              top: 8,
              right: 0,
              child: Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  activeColor: Theme.of(context).accentColor,
                  value: AppData.supplier.id == item.supplier?.id,
                  onChanged: (bool value) async {
                    String reason;
                    if(!value){
                      reason = await showDialog(context: context,builder: (context){
                        return CancelOrderSupplier();
                      });
                      print(reason);
                      if(!value && reason==null){
                        return;
                      }
                    }
                    openLoadingDialog(context, "Submitting");
                    await HaweyatiService.patch('orders/add-supplier', {
                      'item': widget.index,
                      'supplier': AppData.supplier.toJson(),
                      '_id': widget.orderId,
                      'flag': value,
                      'reason': reason
                    });

                    if(value){
                      item.supplier = AppData.supplier;
                    } else {
                      item.supplier = null;
                    }
                    setState(() {

                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
