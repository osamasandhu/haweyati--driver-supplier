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
import 'package:haweyati_supplier_driver_app/src/models/services/finishing-material/model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/orders/select-driver_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/supplier-order-utils.dart';
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
import 'supplier-order-action-buttons.dart';


class SupplierOrderDetailPage extends StatefulWidget {
  final Order order;
  SupplierOrderDetailPage(this.order);

  @override
  _SupplierOrderDetailPageState createState() => _SupplierOrderDetailPageState();
}

class _SupplierOrderDetailPageState extends State<SupplierOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
      ScrollableView.sliver(
        bottom: SupplierOrderActionButton(order: widget.order,),
          showBackground: true,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          appBar: HaweyatiAppBar(actions: [
            IconButton(
                icon: Image.asset(CustomerCareIcon, width: 20),
                // onPressed: () => Navigator.of(context).pushNamed(HELPLINE_PAGE)
            )
          ]),
          children: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
              sliver: SliverToBoxAdapter(child: Center(child: SizedBox(
                width: 360,
                child: OrderDetailHeader(widget.order.status.index))
              )),
            ),

            SliverToBoxAdapter(child: OrderMeta(widget.order)),

            SliverPadding(
              padding: const EdgeInsets.only(bottom: 15, top: 10),
              sliver: SliverToBoxAdapter(child: LocationPicker(
                initialValue: widget.order.location,
                onChanged: (null),
                edit: false,)),
            ),

            // if(widget.order.type == OrderType.finishingMaterial)  SliverPadding(
            //   padding: const EdgeInsets.only(bottom: 0, top: 0),
            //   sliver: SliverToBoxAdapter(child: CheckboxListTile(
            //     onChanged: (bool value){
            //       setState(() {widget.order.items.every((element) => (element.item as FinishingMaterialOrderItem).selected = value);});
            //     },
            //     title: Text("Accept All Items",style: TextStyle(color: Theme.of(context).primaryColor),),
            //     value: widget.order.items.every((e) => (e.item as FinishingMaterialOrderItem).selected),
            //   )),
            // ),

          SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) => OrderItemWidget(
                        widget.order.items[index],
                        SupplierUtils.hasAcceptedFinishingItems(widget.order)),
                childCount: widget.order.items.length,
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

                    RichPriceText(price: widget.order.total - widget.order.deliveryFee, fontSize: 13)
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

                      RichPriceText(price: widget.order.total, fontWeight: FontWeight.bold, fontSize: 18)
                    ])
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
                 if(widget.order.payment !=null) Table(children: [
                    TableRow(children: [
                      Text(lang.paymentType, style: TextStyle(
                        height: 2,
                        fontSize: 13,
                        fontFamily: 'Lato',
                        color: Colors.grey.shade600,
                      )),

                      Text(widget.order.payment, textAlign: TextAlign.right, style: TextStyle(
                          fontSize: 13
                      ))
                    ]),
                  if(widget.order.deliveryFee != null) TableRow(children: [
                     Text(lang.deliveryFee, style: TextStyle(
                       height: 2,
                       fontSize: 13,
                       fontFamily: 'Lato',
                       color: Colors.grey.shade600,
                     )),

                     RichPriceText(price: widget.order.deliveryFee)
                   ])
                  ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
                ],
              ),
            ),
          if(widget.order.driver !=null)  SliverToBoxAdapter(
              child: DarkContainer(
                margin: const EdgeInsets.only(bottom: 15,top: 15),
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Driver",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  ),),
                  ListTile(
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
                              image: widget.order.driver.profile.image !=null? NetworkImage(HaweyatiService.resolveImage(widget.order.driver.profile.image.name))
                                  : AssetImage("assets/icons/avatar.png")
                          )
                      ),
                    ),
                    title: Text(widget.order.driver.profile.name, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(widget.order.driver.profile.contact, style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],),
              ),
            ),
            if(widget.order.customer !=null)  SliverToBoxAdapter(
              child: DarkContainer(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Customer",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14
                  ),),
                  ListTile(
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
                              image: widget.order.customer.profile.image !=null? NetworkImage(HaweyatiService.resolveImage(widget.order.customer.profile.image.name))
                                  : AssetImage("assets/icons/avatar.png")
                          )
                      ),
                    ),
                    title: Text(widget.order.customer.profile.name, style: TextStyle()),
                    subtitle: Text(widget.order.customer.profile.contact, style: TextStyle()),
                  )
                ],),
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
    return SizedBox();
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
              (widget.order.status == OrderStatus.accepted) )
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

                    if(value && widget.order.type == OrderType.dumpster){
                     Driver _driver = await CustomNavigator.navigateTo(context, SelectDriverPage());
                     if(_driver!=null){
                       openLoadingDialog(context, "Submitting");
                       await HaweyatiService.patch('orders/add-supplier', {
                         'item': widget.index,
                         'supplier': AppData.supplier.toJson(),
                         '_id': widget.orderId,
                         'flag': value,
                         'reason': reason
                       });
                       var res = await HaweyatiService.patch('orders/add-driver', {
                         'driver' : _driver.serialize(),
                         '_id' :  widget.order.id,
                         'flag' : true
                       });

                       if(value){
                         item.supplier = AppData.supplier;
                       } else {
                         item.supplier = null;
                       }
                       setState(() {

                       });
                       Navigator.pop(context);
                       Navigator.pop(context);
                       return;
                     }
                    }
                    return;
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
