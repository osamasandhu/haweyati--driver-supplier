import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';

import '../../../../widgits/emptyContainer.dart';

class MutilpeOrders extends StatefulWidget {
  @override
  _MutilpeOrdersState createState() => _MutilpeOrdersState();
}

class _MutilpeOrdersState extends State<MutilpeOrders> {

  bool value =false;
  bool value2 =false;
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
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildtext("Order Date- 02 July 2020, 08:06 Pm"),
                      CupertinoSwitch(activeColor: Theme.of(context).accentColor, value: value, onChanged: (val){

                        setState(() {
                          value=val;
                        });
                      })
                    ],
                  ),
                  SizedBox(height: 10),
                  _buildtext("Order ID - HW18234",),
                  SizedBox(height: 15),
                  _buildImageRow(color: Theme.of(context).accentColor,name: "Item 1"),
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




        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: EmptyContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildtext("Order Date- 02 July 2020, 08:06 Pm"),
                      CupertinoSwitch(activeColor: Theme.of(context).accentColor, value: value2, onChanged: (val){

                        setState(() {
                          value2=val;
                        });
                      })
                    ],
                  ), SizedBox(height: 10),
                  _buildtext("Order ID - HW1364",),
                  SizedBox(height: 15),
                  _buildImageRow(color: Theme.of(context).primaryColor,name: "Item 2"),
                  SizedBox(height: 20),
                  Row(children: <Widget>[
                    _buildtext("Quantity"),
                    _buildtext("3 Piece"),
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
                  SizedBox(height: 15,),
                  Row(children: <Widget>[
                    _buildtext("Total"),
                    Text("364 SR", style: TextStyle(fontWeight: FontWeight.bold),)
                  ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
                ],
              ),
            ),
          ),
        ),



        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: EmptyContainer(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Padding(
                  child: heading(heading: "Customer Information"),
                  padding: const EdgeInsets.only(bottom: 10)
              ),
              Row(children: <Widget>[
                Container(width: 60, height: 60, color: Theme.of(context).accentColor),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    children: <Widget>[
                      Text("Arslan", style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      )),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text("0347-2363720"),
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                )
              ]),
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child:
                  Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                    child: Padding
                      (
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Row(
                        children: <Widget>
                        [
                          Icon(Icons.location_on),
                          Expanded(
                              child: Text("data sdsa ddsv  ds dsds ds ds dd d d ds ds ds dsdd d")
                          ),
                        ],
                      ),
                    ),)
                //                CupertinoTextField(readOnly: true,
//                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
//                  suffix: Padding(
//                    padding: const EdgeInsets.all(8),
//                    child: Icon(Icons.map),
//                  ),
//                  decoration: BoxDecoration(
//                    color: Colors.grey.shade300,
//                    borderRadius: BorderRadius.circular(8),
//                  ),
//                  style: TextStyle(
//                      color: Colors.grey.shade600
//                  ),
//                  controller: TextEditingController(text: "address a ksnlsanf samf ljjl j ckl askl salkf akl fkla fkl sdasd as das d asd as da sd as das d as dasd as d asd "),
//                ),
              ),
            ], crossAxisAlignment: CrossAxisAlignment.start),
          )),
        ),

      ])),

    );
  }

  Widget _buildtext(String text) {
    return Text(text,style: TextStyle(fontSize: 11),);
  }
  Widget _buildImageRow({String name ,Color color}){
    return Row(
      children: <Widget>[
        Container(width: 60,height: 60,color: color,),
        SizedBox(
          width: 12,
        ),
        Text(name,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }



  Widget heading({String heading}) {
    return  Text(
      heading,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    )
    ;
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
