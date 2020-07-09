import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/all-orders_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/pending-orders.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/selected-orders.dart';

class SupplierHomePage extends StatefulWidget {


  @override
  _SupplierHomePageState createState() => _SupplierHomePageState();
}

class _SupplierHomePageState extends State<SupplierHomePage> {

  @override
  Widget build(BuildContext context) {
    return      CupertinoTabScaffold(
      tabBuilder:(context, index) {
        switch (index) {
          case 0:
            return AllOrdersPage();
            break;
          case 1:
            return SupplierSelectedOrders();
            break;
          case 2:
            return PendingOrders();
            break;
          default:
            return AllOrdersPage();
            break;
        }
      },
      tabBar: CupertinoTabBar(
        activeColor: Colors.white,
        backgroundColor: Theme.of(context).primaryColor,

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("All Orders")
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            title: Text("Selected")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Pending")
          )

        ],
      ),
    );
  }
}
