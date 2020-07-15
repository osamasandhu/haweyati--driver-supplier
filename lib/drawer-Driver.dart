import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/addDriver.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';

class DrawerDriverPage extends StatefulWidget {
  @override
  _DrawerDriverPageState createState() => _DrawerDriverPageState();
}

class _DrawerDriverPageState extends State<DrawerDriverPage> {

  String path ="C:\Users\Osama\Downloads";
  bool isReady ;


  @override

  Widget build(BuildContext context) {
    return

Scaffold(appBar: HaweyatiAppBar(),floatingActionButton: SizedBox( width: 70,height: 70, child: FloatingActionButton( backgroundColor: Colors.white, onPressed: (){CustomNavigator.navigateTo(context, AddDriverPage());},child: Icon(Icons.add,size: 40,color: Theme.of(context).primaryColor,),)),
  body:   CustomScrollView(slivers: <Widget>[
  
  
  
    SliverList(delegate: SliverChildBuilderDelegate((context,i){
  
  
  
      return Column(
  
        children: <Widget>[
  
  
  
          ListTile(
  
            leading:CircleAvatar(child: Icon(Icons.person_outline),backgroundColor: Theme.of(context).primaryColor,),
  
            //     Image.asset("assets/images/notification_thumb.png",height: 40,width: 40,),
  
            title: Row(
              children: <Widget>[
                Expanded(child: Text("Ali")),        SizedBox(width: 10,),         Expanded(child: Text("0325-2626325")),

              ],mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
  
            subtitle: Padding(
  
              padding: const EdgeInsets.only(top: 8),
  
              child: Row(
                children: <Widget>[
                  Expanded(child: Text("MNP-2364")),        SizedBox(width: 10,),         Expanded(child: Text("Honda")),

                ],mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
  
            ),     ),
  
          Divider()
  
        ],
  
      );
  
    })),
  
  ],),
);


  }
}
