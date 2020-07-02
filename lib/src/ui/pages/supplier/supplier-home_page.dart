import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/all-orders_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/selected-ordes.dart';

class SupplierHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (context, i) {
        return i == 0 ? AllOrdersPage(): SelectedOrders();
      },
      tabBar: CupertinoTabBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text("All Orders")
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            title: Text("Selected")
          )
        ],
      ),
    );
  }
}
