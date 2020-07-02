import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';

import '../../../../emptyContainer.dart';

class DriverViewAllOrders extends StatefulWidget {
  @override
  _DriverViewAllOrdersState createState() => _DriverViewAllOrdersState();
}

class _DriverViewAllOrdersState extends State<DriverViewAllOrders> {
  @override
  Widget build(BuildContext context) {
    return ScrollablePage(
      title: 'Order Details',
      subtitle: 'asdasdasdasd asd as da sd as da sd asd ',

      child: SliverList(delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: EmptyContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildtext("Order Date- 23 March 2020, 12:23 Pm"),
                  SizedBox(height: 10),
                  _buildtext("Order ID - HW18234",),
                  SizedBox(height: 15),
                  _buildImageRow(),
                  SizedBox(height: 20),
                  Row(children: <Widget>[
                    _buildtext("Quantity"),
                    _buildtext("1 Piece"),
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  SizedBox(height: 15,),
                  Row(children: <Widget>[
                    _buildtext("Total"),
                    Text("203 SR", style: TextStyle(fontWeight: FontWeight.bold),)
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
                ],
              ),
            ),
          ),
        ),

_shopcustomer(context: context,head: "Shop Information",name: "Ali",address: "sknfoiasn k skjc askjc sjk ",phone: "0347-26136150"),
        _shopcustomer(context: context,head: "Customer Information",name: "Arslan",address: "sknfoiasn k skjc askjc sjk ",phone: "0346-9568123"),






      ])),

      action: "Accept",
      onAction: () {
      },
      showButtonBackground: true,
    );
  }

  Widget _buildtext(String text) {
    return Text(text,style: TextStyle(fontSize: 11),);
  }
  Widget _buildImageRow(){
    return Row(
      children: <Widget>[
        Container(width: 60,height: 60,color: Theme.of(context).accentColor,),
        SizedBox(
          width: 12,
        ),
        Text("Order",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }




  Widget detail({String title, String trailing}) {
    return ListTile(dense: true,
      title: Text(title),
      trailing: Text(trailing),
    );
  }
  Widget personalInfo({IconData iconData ,String title}){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: <Widget>[
        Icon(iconData,color: Colors.black,),SizedBox(width: 15,),
        Text(title),
      ]),
    );
//      ListTile(
//      dense: true, leading: Icon(iconData,color: Colors.black,)
//      ,title: Text(title),
//    );
  }

  Widget containerDesign({Widget child}){
    return Container(
      // padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:Color(0xfff2f2f2f2),          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),),child:child
    );
  }
}


Widget _shopcustomer({BuildContext context, String head, String name, String phone, String address}){

  return
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: EmptyContainer(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Padding(
              child:Text(
                head,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              padding: const EdgeInsets.only(bottom: 10)
          ),
          Row(children: <Widget>[
            Container(width: 60, height: 60, color: Theme.of(context).accentColor),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                children: <Widget>[
                  Text(name, style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(phone),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ]),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
              Padding
                (
                padding: const EdgeInsets.all(8.0),
                child:
                Row(
                  children: <Widget>
                  [
                    Icon(Icons.location_on),
                    Expanded(
                        child: Text(address)
                    ),
                  ],
                ),
              )
          ),
        ], crossAxisAlignment: CrossAxisAlignment.start),
      )),
    );

}