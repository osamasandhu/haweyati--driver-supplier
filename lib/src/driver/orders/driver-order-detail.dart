// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:haweyati_supplier_driver_app/model/customer/customer-model.dart';
// import 'package:haweyati_supplier_driver_app/model/order/order_model.dart';
// import 'package:haweyati_supplier_driver_app/model/supplier/supplier_model.dart';
// import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
// import 'package:haweyati_supplier_driver_app/src/driver-supplier-map.dart';
// import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
// import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
// import 'package:haweyati_supplier_driver_app/utils/date-formatter.dart';
// import 'package:haweyati_supplier_driver_app/utils/haweyati-data.dart';
// import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';
// import 'package:haweyati_supplier_driver_app/widgits/emptyContainer.dart';
// import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';
//
// class DriverOrderDetail extends StatefulWidget {
//   final Order order;
//   DriverOrderDetail({this.order});
//
//   @override
//   _DriverOrderDetailState createState() => _DriverOrderDetailState();
// }
//
// class _DriverOrderDetailState extends State<DriverOrderDetail> {
//
//   List<LatLng> wayPoints = [];
//   List<int> selectedOrderItems = [];
//
//   generatedWayPoints () {
//     wayPoints.clear();
//     widget.order..order.items.forEach((element) {
//       wayPoints.add(LatLng(element.supplierModel.location.latitude,element.supplierModel.location.longitude));
//     });
//   }
//
//
//   @override
//   void initState() {
//     super.initState();
//     generatedWayPoints();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ScrollablePage(
//       title: 'Order Details',
//       subtitle: '',
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Theme.of(context).accentColor,
//         child: Icon(Icons.map,color: Colors.white,),
//         onPressed: () async {
//           print(wayPoints);
//           CustomNavigator.navigateTo(context, DriverRouteMapPage(wayPoints: wayPoints,));
//         },
//       ),
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
//         customer(customer: widget.order.customer)
//       ])),
//
//       action: "Accept",
//       onAction: () async {
//       bool confirm =  await showDialog(context: context,
//         builder: (context){
//           return ConfirmationDialog(message: 'accept this order',);
//         });
//       if(confirm!=null && confirm){
//         openLoadingDialog(context, "Accepting order");
//        var res = await HaweyatiService.patch('orders/add-driver', {
//           'driver' : AppData.driver.serialize(),
//           '_id' : widget.order.id,
//           'flag' : true
//         });
//         // Navigator.pop(context);
//         Navigator.pop(context);
//       }
//         },
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
//         child: Column(children: [
//           items[i].buildWidget(context),
//           supplier(supplier: items[i].supplierModel),
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
//   Widget supplier({SupplierModel supplier}){
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: EmptyContainer(child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(children: <Widget>[
//           Padding(
//               child:Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                    "Supplier Information",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                   supplier.location !=null ? SizedBox(
//                     height: 25,
//                     child: FlatButton(
//                       color: Theme.of(context).accentColor,
//                       textColor: Colors.white,
//                       shape: StadiumBorder(),
//                       child: Text("View on Map"),
//                       onPressed: (){
//
//                       },
//                     ),
//                   ) : SizedBox()
//                 ],
//               ),
//               padding: const EdgeInsets.only(bottom: 10)
//           ),
//           Row(children: <Widget>[
//             Container(
//               width: 60, height: 60,
//               child: supplier.person.image !=null ? Image.network(HaweyatiService.resolveImage(supplier.person.image.name)) :
//               Image.asset("assets/images/icon.png"),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 12),
//               child: Column(
//                 children: <Widget>[
//                   Text( supplier.person.name, style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold
//                   )),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Text( supplier.person.contact),
//                   )
//                 ],
//                 crossAxisAlignment: CrossAxisAlignment.start,
//               ),
//             )
//           ]),
//           Padding(
//               padding: const EdgeInsets.only(top: 10),
//               child:
//               Padding
//                 (
//                 padding: const EdgeInsets.all(8.0),
//                 child:
//                 Row(
//                   children: <Widget>
//                   [
//                     Icon(Icons.location_on),
//                     Expanded(
//                         child: Text( supplier.location.address)
//                     ),
//                   ],
//                 ),
//               )
//           ),
//         ], crossAxisAlignment: CrossAxisAlignment.start),
//       )),
//     );
//   }
//
//   Widget customer({Customer customer}){
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 15),
//       child: EmptyContainer(child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(children: <Widget>[
//           Padding(
//               child:Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "Customer Information",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                   ),
//                  customer.location !=null ? SizedBox(
//                     height: 25,
//                     child: FlatButton(
//                       color: Theme.of(context).accentColor,
//                       textColor: Colors.white,
//                       shape: StadiumBorder(),
//                       child: Text("View on Map"),
//                       onPressed: (){
//
//                       },
//                     ),
//                   ) : SizedBox()
//                 ],
//               ),
//               padding: const EdgeInsets.only(bottom: 10)
//           ),
//           Row(children: <Widget>[
//             Container(
//               width: 60, height: 60,
//               child: customer.profile.image !=null ? Image.network(HaweyatiService.resolveImage(customer.profile.image.name)) :
//               Image.asset("assets/images/icon.png"),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 12),
//               child: Column(
//                 children: <Widget>[
//                   Text( customer.profile.name, style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold
//                   )),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 8),
//                     child: Text( customer.profile.contact),
//                   )
//                 ],
//                 crossAxisAlignment: CrossAxisAlignment.start,
//               ),
//             )
//           ]),
//       customer.location !=null ?  Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: <Widget>
//               [
//                 Icon(Icons.location_on),
//                 Expanded(
//                     child: Text( customer.location?.address ?? '')
//                 ),
//               ],
//             ),
//           ) : SizedBox(),
//         ], crossAxisAlignment: CrossAxisAlignment.start),
//       )),
//     );
//   }
// }
//
//
//
