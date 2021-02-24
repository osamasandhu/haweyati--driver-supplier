import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/rich-price-text.dart';
import 'package:haweyati_supplier_driver_app/widgits/order-location-picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'my-orders_page.dart';
import 'order-mutual-widgets.dart';
import 'supplier-order-utils.dart';

List<Widget> orderViewBuilder(Order order,AppLocalizations lang,[Widget finishingAcceptanceWidget]) {
  return [
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
        sliver: SliverToBoxAdapter(child: Center(child: SizedBox(
            width: 360,
            child: OrderDetailHeader(order.status.index))
        )),
      ),
      SliverToBoxAdapter(child: OrderMeta(order)),
    if(AppData.isDriver && order.status != OrderStatus.pending && order.type!=OrderType.deliveryVehicle)  SliverPadding(
          padding: const EdgeInsets.only(bottom: 15, top: 10),
          sliver: SliverToBoxAdapter(child: LocationPicker(
            title: 'Pick Up Location',
            initialValue: order.supplier.location,
            onChanged: (null),
            edit: false,)),
        ),
      SliverPadding(
        padding: const EdgeInsets.only(bottom: 15, top: 5),
        sliver: SliverToBoxAdapter(child: DropOffLocation(order.location)),
      ),
      if(AppData.isSupplier && order.type == OrderType.finishingMaterial && order.status == OrderStatus.pending)
        finishingAcceptanceWidget,
      SliverList(delegate: SliverChildBuilderDelegate(
            (context, index) => OrderItemWidget(
            order.items[index],
            SupplierUtils.hasAcceptedFinishingItems(order)),
        childCount: order.items.length,
      )),
      SliverToBoxAdapter(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
          children: [
            TableRow(children: [
              Text('VAT (15%) ', style: TextStyle(
                height: 2, fontSize: 13,
                fontFamily: 'Lato',
                color: Colors.grey.shade600,
              )),

              RichPriceText(price: (order.total - order.deliveryFee) * .15, fontSize: 13)
            ]),
            TableRow(children: [
              Text(lang.subtotal, style: TextStyle(
                height: 2, fontSize: 13,
                fontFamily: 'Lato',
                color: Colors.grey.shade600,
              )),

              RichPriceText(price: order.total - order.deliveryFee, fontSize: 13)
            ]),
            if(order.deliveryFee!=null) TableRow(children: [
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
    if(order.customer!=null) personBuilder(type: 'Customer',image: order.customer?.profile?.image?.name,name: order.customer.profile.name,contact: order.customer.profile.contact),
    if(order.supplier!=null && !AppData.isSupplier) personBuilder(type: 'Supplier',image: order.supplier?.person?.image?.name,name: order.supplier.person.name,contact: order.supplier.person.contact),
    if(order.driver!=null && !AppData.isDriver) personBuilder(type: 'Driver',image: order.driver?.profile?.image?.name,name: order.driver.profile.name,contact: order.driver.profile.contact),
    ];
}

Widget personBuilder({String type,String image,String name,String contact}){
  return SliverToBoxAdapter(
    child: DarkContainer(
      margin: const EdgeInsets.only(bottom: 10,top: 0),
      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14
          ),),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
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
                      image: image !=null? NetworkImage(HaweyatiService.resolveImage(image))
                          : AssetImage("assets/images/app-logo.png")
                  )
              ),
            ),
            title: Text(name, style: TextStyle()),
            subtitle: Text(contact, style: TextStyle()),
            trailing: Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: FlatButton.icon(
                minWidth: 30,
                  color: Color(0xFFFF974D),
                label: SizedBox(),
                  shape: CircleBorder(),
                  icon: Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Icon(CupertinoIcons.phone_fill,size: 20,color: Colors.white,),
                  ), onPressed: () async {
                   launch("tel:${contact}");
              }),
            ),
          )
        ],),
    ),
  );
}