import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/building-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/dumpster/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/no-scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/rich-price-text.dart';
import 'package:intl/intl.dart';

import 'order-detail_page.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  var _orderId = '';
  final _service = OrdersService();
  final _key = GlobalKey<LiveScrollableViewState>();

  @override
  Widget build(BuildContext context) {
    var view;
    view = LiveScrollableView(
      key: _key,
      header: Padding(
        padding: const EdgeInsets.all(15),
        child: CupertinoTextField(
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(15, 7, 5, 7),
            child: Icon(CupertinoIcons.search,
                size: 21, color: Colors.grey.shade400
            ),
          ),
          style: TextStyle(fontSize: 15),
          placeholderStyle: TextStyle(
            fontSize: 15,
            fontFamily: 'Lato',
            color: Colors.grey.shade400,
          ),
          placeholder: 'Item Name or order number',
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.shade200
          ),
          onChanged: (val) async {
            _orderId = val;
            await view.reload();
          },
        ),
      ),
      /// TODO: Fix this
      // loader: () => _service.orders(orderId: _orderId),
      builder: (context, order) => GestureDetector(
        onTap: () => navigateTo(context, OrderDetailPage(order)),
        child: _OrderListTile(order)
      ),
    );

    return NoScrollView(
      body: view
    );
  }
}

class _OrderListTile extends StatelessWidget {
  final Order order;
  _OrderListTile(this.order);

  @override
  Widget build(BuildContext context) {
    return DarkContainer(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      child: Wrap(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: OrderMeta(order),
        ),

        for (final item in order.items)
          OrderItemTile(item),

        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(children: [
            Text('Total', style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600
            )),
            Spacer(),
            RichPriceText(
              price: order.total,
              fontWeight: FontWeight.bold,
            ),
          ]),
        )
      ]),
    );
  }
}

class _OrderStatus extends Container {
  _OrderStatus(final OrderStatus status): super(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 4.5
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: _color(status)
    ),
    child: Text(_text(status), style: TextStyle(
      color: Colors.white,
      fontSize: 10
    ))
  );

  static String _text(OrderStatus status) {
    switch (status) {
      case OrderStatus.dispatched:
      case OrderStatus.active:
        return 'Active';
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.closed:
        return 'Completed';
      case OrderStatus.rejected:
        return 'Canceled';
    }

    return '';
  }
  static Color _color(OrderStatus status) {
    switch (status) {
      case OrderStatus.dispatched:
      case OrderStatus.active:
        return Colors.green;
      case OrderStatus.pending:
        return Color(0xFFFF974D);
      case OrderStatus.closed:
        return Color(0xFF313F53);
      case OrderStatus.rejected:
        return Colors.red;
    }

    return null;
  }
}

class OrderMeta extends Row {
  OrderMeta(Order order): super(children: [
    Column(children: [
      RichText(text: TextSpan(
        text: 'Order Date - ',
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600
        ),
        children: [
          TextSpan(
            text: DateFormat('d MMM y,').add_jm().format(order.createdAt),
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF313F53)
            ),
          )
        ]
      )),

      SizedBox(height: 3),

      RichText(text: TextSpan(
        text: 'Order ID - ',
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey.shade600
        ),
        children: [
          TextSpan(
            text: order.number.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF313F53)
            ),
          )
        ]
      ))
    ], crossAxisAlignment: CrossAxisAlignment.start),

    Spacer(),
    _OrderStatus(order.status)
  ], crossAxisAlignment: CrossAxisAlignment.start);
}

class OrderItemTile extends StatelessWidget {
  final OrderItemHolder item;
  OrderItemTile(this.item);

  @override
  Widget build(BuildContext context) {
    int qty = 1;
    String title;
    String imageUrl;
    dynamic product = item.item.product;

    if (item.item is DumpsterOrderItem) {
      title = '${int.parse(product.size)} Yards';
      imageUrl = product.image.name;
    } else if (item.item is BuildingMaterialOrderItem) {
      qty = (item.item as BuildingMaterialOrderItem).qty;
      title = product.name;
      imageUrl = product.image.name;
    } else if (item.item is FinishingMaterialOrderItem) {
      qty = (item.item as FinishingMaterialOrderItem).qty;
      title = product.name;
      imageUrl = product.images.name;
    }

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Container(
        width: 60,
        decoration: BoxDecoration(
          color: Color(0xEEFFFFFF),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
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
      title: Text(title.toString() ,style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(AppLocalizations.of(context).nProducts(qty)),
    );
  }
}
