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
//  int currentTabIndex = 0;
//
//  onTapped(int index) {
//    setState(() {
//      currentTabIndex = index;
//    });
//  }
//
//  List<Widget> tabs = [
//AllOrdersPage(),
//SelectedOrders(),
//Center(child: Text("data"))
//  ];

  @override
  Widget build(BuildContext context) {
    return



//      Scaffold(
//        body: tabs[currentTabIndex],
//        bottomNavigationBar: BottomNavigationBar(
//          backgroundColor: Theme.of(context).primaryColor,
//            selectedItemColor: Colors.white,
//            currentIndex: currentTabIndex,
//            onTap: onTapped,
//            items: [
//              BottomNavigationBarItem(
//                  icon: Icon(Icons.list), title: Text("All Orders ")),
//              BottomNavigationBarItem(
//                  icon: Icon(Icons.search), title: Text("Search")),
//              BottomNavigationBarItem(
//                  icon: Icon(Icons.person), title: Text("User Info"))
//            ]),
//      );
//


      CupertinoTabScaffold(
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
