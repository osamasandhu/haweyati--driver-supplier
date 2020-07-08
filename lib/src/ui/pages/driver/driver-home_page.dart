import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-all-orders_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-selected-ordes.dart';

class DriverHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return






      CupertinoTabScaffold(
      tabBuilder:(context, index) {
        switch (index) {
          case 0:
            return DriverAllOrdersPage();
            break;
          case 1:
            return DriverSelectedOrders();
            break;
          default:
            return DriverAllOrdersPage();
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
            title: Text("Accepted")
          ),

        ],
      ),
    );
  }
}
