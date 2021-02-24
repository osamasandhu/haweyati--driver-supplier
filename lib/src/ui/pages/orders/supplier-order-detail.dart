import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'order-mutual-detail.dart';
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
            ...orderViewBuilder(widget.order, lang,SliverToBoxAdapter(
              child: CheckboxListTile(
                title: Text("Accept All Items"),
                onChanged: (bool value){
                  if(value){
                    widget.order.items.forEach((element) {
                      (element.item as FinishingMaterialOrderItem).selected = true;
                    });
                  } else {
                    widget.order.items.forEach((element) {
                      (element.item as FinishingMaterialOrderItem).selected =false;
                    });
                  }
                  setState(() {});
                },
                value: widget.order.items.map((e) => (e.item as FinishingMaterialOrderItem)).every((element) => element.selected ==true),
              ),
            )),
          //   SliverPadding(
          //     padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
          //     sliver: SliverToBoxAdapter(child: Center(child: SizedBox(
          //       width: 360,
          //       child: OrderDetailHeader(widget.order.status.index))
          //     )),
          //   ),
          //
          //   SliverToBoxAdapter(child: OrderMeta(widget.order)),
          //
          //   SliverPadding(
          //     padding: const EdgeInsets.only(bottom: 15, top: 10),
          //     sliver: SliverToBoxAdapter(child: LocationPicker(
          //       initialValue: widget.order.location,
          //       onChanged: (null),
          //       edit: false,)),
          //   ),
          //
          //   if(widget.order.type == OrderType.finishingMaterial && widget.order.payment == null)  SliverPadding(
          //     padding: const EdgeInsets.only(bottom: 0, top: 0),
          //     sliver: SliverToBoxAdapter(child: CheckboxListTile(
          //       onChanged: (bool value){
          //         setState(() {widget.order.items.every((element) => (element.item as FinishingMaterialOrderItem).selected = value);});
          //       },
          //       title: Text("Accept All Items",style: TextStyle(color: Theme.of(context).primaryColor),),
          //       value: widget.order.items.every((e) => (e.item as FinishingMaterialOrderItem).selected),
          //     )),
          //   ),
          //
          // SliverList(delegate: SliverChildBuilderDelegate(
          //           (context, index) => OrderItemWidget(
          //               widget.order.items[index],
          //               SupplierUtils.hasAcceptedFinishingItems(widget.order)),
          //       childCount: widget.order.items.length,
          //   )),
          //
          //   SliverToBoxAdapter(
          //     child: Table(
          //       defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
          //       children: [
          //         TableRow(children: [
          //           Text(lang.subtotal, style: TextStyle(
          //             height: 2, fontSize: 13,
          //             fontFamily: 'Lato',
          //             color: Colors.grey.shade600,
          //           )),
          //
          //           RichPriceText(price: widget.order.total - widget.order.deliveryFee, fontSize: 13)
          //         ]),
          //        if(widget.order.deliveryFee!=null) TableRow(children: [
          //           Text(lang.deliveryFee, style: TextStyle(
          //             height: 2, fontSize: 13,
          //             fontFamily: 'Lato',
          //             color: Colors.grey.shade600,
          //           )),
          //
          //           RichPriceText(price: widget.order.deliveryFee, fontSize: 13)
          //         ])
          //       ],
          //     ),
          //   ),
          //   SliverToBoxAdapter(child: Divider()),
          //   SliverToBoxAdapter(
          //     child: Column(
          //       children: [
          //         Table(children: [
          //           TableRow(children: [
          //             Text(lang.total, style: TextStyle(
          //               height: 2,
          //               fontSize: 13,
          //               fontFamily: 'Lato',
          //               color: Colors.grey.shade600,
          //             )),
          //
          //             RichPriceText(price: widget.order.total, fontWeight: FontWeight.bold, fontSize: 18)
          //           ])
          //         ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
          //        if(widget.order.payment !=null) Table(children: [
          //           TableRow(children: [
          //             Text(lang.paymentType, style: TextStyle(
          //               height: 2,
          //               fontSize: 13,
          //               fontFamily: 'Lato',
          //               color: Colors.grey.shade600,
          //             )),
          //
          //             Text(widget.order.payment, textAlign: TextAlign.right, style: TextStyle(
          //                 fontSize: 13
          //             ))
          //           ]),
          //         if(widget.order.deliveryFee != null) TableRow(children: [
          //            Text(lang.deliveryFee, style: TextStyle(
          //              height: 2,
          //              fontSize: 13,
          //              fontFamily: 'Lato',
          //              color: Colors.grey.shade600,
          //            )),
          //
          //            RichPriceText(price: widget.order.deliveryFee)
          //          ])
          //         ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
          //       ],
          //     ),
          //   ),
          // if(widget.order.driver !=null)  SliverToBoxAdapter(
          //     child: DarkContainer(
          //       margin: const EdgeInsets.only(bottom: 15,top: 15),
          //       padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //         Text("Driver",style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             fontSize: 14
          //         ),),
          //         ListTile(
          //           contentPadding: const EdgeInsets.only(bottom: 15),
          //           leading: Container(
          //             width: 60,
          //             decoration: BoxDecoration(
          //                 color: Color(0xEEFFFFFF),
          //                 borderRadius: BorderRadius.circular(8),
          //                 boxShadow: [
          //                   BoxShadow(
          //                       blurRadius: 5,
          //                       spreadRadius: 1,
          //                       color: Colors.grey.shade500
          //                   )
          //                 ],
          //                 image: DecorationImage(
          //                     fit: BoxFit.cover,
          //                     image: widget.order.driver.profile.image !=null? NetworkImage(HaweyatiService.resolveImage(widget.order.driver.profile.image.name))
          //                         : AssetImage("assets/icons/avatar.png")
          //                 )
          //             ),
          //           ),
          //           title: Text(widget.order.driver.profile.name, style: TextStyle(fontWeight: FontWeight.bold)),
          //           subtitle: Text(widget.order.driver.profile.contact, style: TextStyle(fontWeight: FontWeight.bold)),
          //         )
          //       ],),
          //     ),
          //   ),
          //   if(widget.order.customer !=null)  SliverToBoxAdapter(
          //     child: DarkContainer(
          //       padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //         Text("Customer",style: TextStyle(
          //           fontWeight: FontWeight.bold,
          //           fontSize: 14
          //         ),),
          //         ListTile(
          //           contentPadding: const EdgeInsets.only(bottom: 15),
          //           leading: Container(
          //             width: 60,
          //             decoration: BoxDecoration(
          //                 color: Color(0xEEFFFFFF),
          //                 borderRadius: BorderRadius.circular(8),
          //                 boxShadow: [
          //                   BoxShadow(
          //                       blurRadius: 5,
          //                       spreadRadius: 1,
          //                       color: Colors.grey.shade500
          //                   )
          //                 ],
          //                 image: DecorationImage(
          //                     fit: BoxFit.cover,
          //                     image: widget.order.customer.profile.image !=null? NetworkImage(HaweyatiService.resolveImage(widget.order.customer.profile.image.name))
          //                         : AssetImage("assets/icons/avatar.png")
          //                 )
          //             ),
          //           ),
          //           title: Text(widget.order.customer.profile.name, style: TextStyle()),
          //           subtitle: Text(widget.order.customer.profile.contact, style: TextStyle()),
          //         )
          //       ],),
          //     ),
          //   )
          ]
      ),
    );
  }
}
