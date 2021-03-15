import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import '../helpline_page.dart';
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
                onPressed: () => CustomNavigator.navigateTo(context, HelplinePage())
            )
          ]),
          children: [
            ...orderViewBuilder(widget.order, lang,widget.order.type == OrderType.finishingMaterial ? SliverToBoxAdapter(
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
            ) : SizedBox()),
          ]
      ),
    );
  }
}
