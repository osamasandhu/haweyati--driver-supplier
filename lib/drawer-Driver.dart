import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/addDriver.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';

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
  
            title: Text("Ali"),
  
            subtitle: Padding(
  
              padding: const EdgeInsets.only(top: 8),
  
              child: Text(loremIpsum.substring(0,36)),
  
            ),     ),
  
          Divider()
  
        ],
  
      );
  
    })),
  
  ],),
);


  }
}
