import 'package:flutter/material.dart';
import 'package:haweyati_client_data_models/widgets/variants-tablerow.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/building-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/delivery-vehicle/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/dumpster/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/finishing-material/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order-item_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/scaffoldings/single-scaffolding/single-scaffolding_orderable.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-container.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/rich-price-text.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';


class OrderItemWidget extends StatelessWidget {
  final OrderItemHolder holder;
  final bool cannotAcceptFinishingItems;
  OrderItemWidget(this.holder,[this.cannotAcceptFinishingItems=true]);

  @override
  Widget build(BuildContext context) {
    final qty = _qty(holder);
    final bool showItem = !(AppData.isDriver && holder.item is FinishingMaterialOrderItem && (holder.item as FinishingMaterialOrderItem).selected);
    return !showItem ? SizedBox(): LocalizedView(
      builder: (context,lang) =>
          DarkContainer(
            margin: const EdgeInsets.only(bottom: 5),
            padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 15),
            child: Column(children: [
              OrderItemTile(holder,cannotAcceptFinishingItems),
              if (holder.item is SingleScaffoldingOrderable)
                Table(children: [
                  TableRow(children: [
                    Text("Days", style: TextStyle(
                      height: 1.6,
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                    Text('${(holder.item as SingleScaffoldingOrderable).days}',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xFF313F53)),
                    )
                  ]),
                  TableRow(children: [
                    Text("Wheels (Set of 4)", style: TextStyle(
                      height: 1.6,
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                    Text('${(holder.item as SingleScaffoldingOrderable).wheels}',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xFF313F53)),
                    )
                  ]),
                  TableRow(children: [
                    Text("Connections (Set of 4)", style: TextStyle(
                      height: 1.6,
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                    Text('${(holder.item as SingleScaffoldingOrderable).connections}',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xFF313F53)),
                    )
                  ]),
                 if( (holder.item as dynamic).mesh !=null) TableRow(children: [
                    Text("Mesh", style: TextStyle(
                      height: 1.6,
                      fontSize: 13,
                      color: Colors.grey,
                    )),
                    Text('${(holder.item as SingleScaffoldingOrderable).mesh} (Quantity: ${(holder.item as SingleScaffoldingOrderable).meshQty})',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Color(0xFF313F53)),
                    )
                  ]),
                ], defaultVerticalAlignment: TableCellVerticalAlignment.baseline),
              if (holder.item is FinishingMaterialOrderItem)
                Table(children: [
                  ...buildVariants((holder.item as FinishingMaterialOrderItem).variants),

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
                  TableRow(children: [
                    Text(lang.price, style: TextStyle(
                      height: 1.6,
                      fontSize: 13,
                      color: Colors.grey,
                    )),

                    RichPriceText(price: (holder.item as FinishingMaterialOrderItem).price)
                  ]),
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
                  TableRow(children: [
                    Text(lang.price, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 2)),
                    RichPriceText(price: holder.subtotal / qty, fontSize: 13)
                  ]),

                  TableRow(children: [
                    Text(lang.total, style: TextStyle(color: Colors.grey.shade600, fontSize: 13, height: 3)),
                    RichPriceText(price: holder.subtotal, fontWeight: FontWeight.bold)
                  ]),
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

class OrderItemTile extends StatefulWidget {
  final OrderItemHolder item;
  final bool cannotAcceptFinishingItems;
  OrderItemTile(this.item,this.cannotAcceptFinishingItems);

  @override
  _OrderItemTileState createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  @override
  Widget build(BuildContext context) {
    bool isFinishingMaterial = widget.item.item is FinishingMaterialOrderItem;
    String title;
    String imageUrl;
    String imagePath;
    dynamic product = widget.item.item.product;

    if (widget.item.item is DumpsterOrderItem) {
      title = '${product.size} Yards';
      imageUrl = product.image.name;
    } else if (widget.item.item is BuildingMaterialOrderItem) {
      title = product.name + " (${(widget.item.item as dynamic).price.unit})";
      imageUrl = product.image.name;
    } else if (widget.item.item is FinishingMaterialOrderItem) {
      title = product.name;
      imageUrl = product.images.name;
    }
    else if (widget.item.item is SingleScaffoldingOrderable) {
      title = product.type;
      imagePath = "assets/images/singleScaffolding.png";
    }
    else if (widget.item.item is DeliveryVehicleOrderItem) {
      title = product.name;
      imageUrl = product.image.name;
    }
    return ListTile(
      contentPadding: const EdgeInsets.only(bottom: 10),
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
                fit: BoxFit.contain,
                image: imagePath == null ?
                NetworkImage(HaweyatiService.resolveImage(imageUrl))
                    : AssetImage(imagePath)
            )
        ),
      ),
      trailing: isFinishingMaterial && AppData.isSupplier  ? Checkbox(
        value: (widget.item.item as FinishingMaterialOrderItem).selected,
        onChanged: widget.cannotAcceptFinishingItems ? null: (bool val){
          setState(() {
            (widget.item.item as FinishingMaterialOrderItem).selected = val;
          });
        },
      ) : null,
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}

class OrderDetailHeader extends StatelessWidget {
  final int status;

  OrderDetailHeader(this.status);

  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Stack(
        children: [
          CustomPaint(painter: OrderStatusPainter(status)),
          Positioned(
            left: 30,
            top: 10,
            child: Icon(Icons.done_all, size: 20, color: Colors.white),
          ),
          Positioned(
            top: 7,
            left: 95,
            child: Image.asset(CartIcon, width: 28, color: Colors.white,),
          ),
          Positioned(
            top: 9,
            left: 169,
            child: Image.asset(SettingsIcon, width: 22, color: Colors.white,),
          ),
          Positioned(
            top: 7,
            right: 95,
            child: Image.asset(DeliveryVehicleIcon, width: 28, color: Colors.white,),
          ),
          Positioned(
            right: 30,
            top: 9,
            child: Image.asset(HomeIcon, width: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class OrderStatusPainter extends CustomPainter {
  final int progress;

  OrderStatusPainter(this.progress);

  static TextPainter _genText(String text) {
    return TextPainter(
      text: TextSpan(
          text: text,
          style: TextStyle(fontSize: 10, color: Colors.grey.shade700)),
      textDirection: TextDirection.ltr,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final xOffset1 = 40.0;
    final xOffset2 = 110.0;
    final xOffset3 = 180.0;
    final xOffset4 = 250.0;
    final xOffset5 = 320.0;

    final txt1 = _genText('Order Placed')..layout();
    final txt2 = _genText('Accepted')..layout();
    final txt3 = _genText('Preparing')..layout();
    final txt4 = _genText('Dispatched')..layout();
    final txt5 = _genText('Delivered')..layout();

    final _donePainter = Paint()
      ..color = Color(0xFFFF974D)
      ..strokeWidth = 1;

    final _unDonePainter = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    txt1.paint(canvas, Offset(xOffset1 - txt1.width / 2, 50));
    txt2.paint(canvas, Offset(xOffset2 - txt2.width / 2, 50));
    txt3.paint(canvas, Offset(xOffset3 - txt3.width / 2, 50));
    txt4.paint(canvas, Offset(xOffset4 - txt4.width / 2, 50));
    txt5.paint(canvas, Offset(xOffset5 - txt5.width / 2, 50));

    canvas.drawLine(Offset(xOffset1, 20), Offset(xOffset2, 20),
        progress > 0 ? _donePainter : _unDonePainter);
    canvas.drawLine(Offset(xOffset2, 20), Offset(xOffset3, 20),
        progress > 2 ? _donePainter : _unDonePainter);
    canvas.drawLine(Offset(xOffset3, 20), Offset(xOffset4, 20),
        progress > 4 ? _donePainter : _unDonePainter);
    canvas.drawLine(Offset(xOffset4, 20), Offset(xOffset5, 20),
        progress > 5 ? _donePainter : _unDonePainter);

    canvas.drawCircle(Offset(xOffset1, 20), 20,
        progress >= 0 ? _donePainter : _unDonePainter);
    canvas.drawCircle(Offset(xOffset2, 20), 20,
        progress >= 1 ? _donePainter : _unDonePainter);
    canvas.drawCircle(Offset(xOffset3, 20), 20,
        progress >= 2 ? _donePainter : _unDonePainter);
    canvas.drawCircle(Offset(xOffset4, 20), 20,
        progress >= 3 ? _donePainter : _unDonePainter);
    canvas.drawCircle(Offset(xOffset5, 20), 20,
        progress >= 4 ? _donePainter : _unDonePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}