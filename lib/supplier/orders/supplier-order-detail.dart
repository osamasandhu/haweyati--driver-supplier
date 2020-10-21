// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:haweyati_supplier_driver_app/model/order/order-item_model.dart';
// import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
// import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
// import 'package:haweyati_supplier_driver_app/utils/date-formatter.dart';
// import 'package:haweyati_supplier_driver_app/widgits/emptyContainer.dart';
// import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';
//
// class SupplierOrderDetail extends StatefulWidget {
//   final Order order;
//   SupplierOrderDetail({this.order});
//
//   @override
//   _SupplierOrderDetailState createState() => _SupplierOrderDetailState();
// }
//
// class _SupplierOrderDetailState extends State<SupplierOrderDetail> {
//
//   List<int> selectedOrderItems = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return ScrollablePage(
//       title: 'Order Details',
//       child: SliverList(delegate: SliverChildListDelegate([
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: EmptyContainer(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   _buildtext("Order Date- ${formattedDate(widget.order.createdAt)},"
//                       " ${TimeOfDay.fromDateTime(widget.order.createdAt).format(context)}"),
//                   SizedBox(height: 10),
//                   _buildtext("Order ID - ${widget.order.orderNo}",),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           child: Column(children: buildItems(context, widget.order.order.items)),
//         ),
//
//
//         // _shopcustomer(context: context,head: "Shop Information",
//         //   name: "Ali",address: "sknfoiasn k skjc askjc sjk ",
//         //    phone: "0347-26136150"),
//         _shopcustomer(context: context,head: "Customer Information",
//             name: widget.order.customer.profile.name,
//             address: widget.order.customer.location?.address ?? '',
//             phone: widget.order.customer.profile.contact),
//       ])),
//
//       showButtonBackground: true,
//     );
//   }
//
//   List<Widget> buildItems(BuildContext context, List<OrderItem> items) {
//     final List<Widget> list = [];
//
//     for (var i = 0; i < items.length; ++i) {
//
//       list.add(ClipRRect(
//         child: Stack(children: [
//           items[i].buildWidget(context),
//           if (items[i].supplierModel?.sId == AppData.supplier.sId)
//             Transform.translate(
//               offset: Offset(-55, -55),
//               child: Transform.rotate(
//                 angle: 225.45,
//                 child: Container(
//                   width: 100,
//                   height: 100,
//                   color: Theme.of(context).accentColor,
//                   child: Align(
//                     alignment: Alignment(0, .97),
//                     child: Text("Accepted", style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 8,
//                         fontWeight: FontWeight.bold
//                     ), textAlign: TextAlign.center),
//                   )
//                 ),
//               )
//             ),
//           if (items[i].supplierModel == null || AppData.supplier.sId == items[i].supplierModel.sId)
//             Positioned(
//               top: 8,
//               right: 0,
//               child: Transform.scale(
//                 scale: 0.7,
//                 child: CupertinoSwitch(
//                   activeColor: Theme.of(context).accentColor,
//                   value: AppData.supplier.sId == items[i].supplierModel?.sId,
//                   onChanged: (bool value) async {
//                     openLoadingDialog(context, "Submitting");
//                     await HaweyatiService.patch('orders/add-supplier', {
//                       'item': i,
//                       'supplier': AppData.supplier.toJson(),
//                       '_id': widget.order.id,
//                       'flag': value
//                     });
//
//                     if (value) {
//                       items[i].supplierModel = AppData.supplier;
//                     } else {
//                       items[i].supplierModel = null;
//                     }
//                     setState(() {});
//
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             )
//           //   ListTile(
//           //     trailing: Padding(
//           //     padding: const EdgeInsets.only(top:8.0),
//           //       child:
//           //   ),
//           // ) :  SizedBox(),
//         ]),
//       ));
//     }
//
//     return list;
//   }
//
//   Widget _buildtext(String text) {
//     return Text(text,style: TextStyle(fontSize: 11),);
//   }
//   Widget _buildImageRow(){
//     return Row(
//       children: <Widget>[
//         Container(width: 60,height: 60,color: Theme.of(context).accentColor,),
//         SizedBox(
//           width: 12,
//         ),
//         Text("Order",
//           style: TextStyle(
//               fontSize: 16, fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }
//
//
//
//
//   Widget detail({String title, String trailing}) {
//     return ListTile(dense: true,
//       title: Text(title),
//       trailing: Text(trailing),
//     );
//   }
//   Widget personalInfo({IconData iconData ,String title}){
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Row(children: <Widget>[
//         Icon(iconData,color: Colors.black,),SizedBox(width: 15,),
//         Text(title),
//       ]),
//     );
// //      ListTile(
// //      dense: true, leading: Icon(iconData,color: Colors.black,)
// //      ,title: Text(title),
// //    );
//   }
//
//   Widget containerDesign({Widget child}){
//     return Container(
//       // padding: EdgeInsets.all(20),
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(
//           color:Color(0xfff2f2f2f2),          boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3), // changes position of shadow
//           ),
//         ],
//           borderRadius: BorderRadius.circular(10),),child:child
//     );
//   }
//
//
// }
//
//
//
// Widget _shopcustomer({BuildContext context, String head, String name, String phone, String address}){
//
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 15),
//     child: EmptyContainer(child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(children: <Widget>[
//         Padding(
//             child:Text(
//               head,
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             padding: const EdgeInsets.only(bottom: 10)
//         ),
//         Row(children: <Widget>[
//           Container(width: 60, height: 60, color: Theme.of(context).accentColor),
//           Padding(
//             padding: const EdgeInsets.only(left: 12),
//             child: Column(
//               children: <Widget>[
//                 Text(name, style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold
//                 )),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Text(phone),
//                 )
//               ],
//               crossAxisAlignment: CrossAxisAlignment.start,
//             ),
//           )
//         ]),
//         Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child:
//             Padding
//               (
//               padding: const EdgeInsets.all(8.0),
//               child:
//               Row(
//                 children: <Widget>
//                 [
//                   Icon(Icons.location_on),
//                   Expanded(
//                       child: Text(address)
//                   ),
//                 ],
//               ),
//             )
//         ),
//       ], crossAxisAlignment: CrossAxisAlignment.start),
//     )),
//   );
//
// }