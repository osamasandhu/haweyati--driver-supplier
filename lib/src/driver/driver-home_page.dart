import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-completed.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-accepted.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-dispatched.dart';
import 'package:haweyati_supplier_driver_app/src/services/drivers_service.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/orders-listing.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';

import 'orders/driver-pending.dart';
import 'profile/driver-drawer.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _currentIndex = 0;

  final _drawerKey = GlobalKey<ScaffoldState>();

  // List<Widget> tabPages = [
  //   OrdersListing(future: OrdersService().driverAllOrders(),),
  //   OrdersListing(future: OrdersService().driverSelectedOrders(),),
  //   OrdersListing(future: OrdersService().driverCompletedOrders(),),
  // ];

  List<Widget> tabPages = [
    DriverPendingOrdersListing(),
    DriverAcceptedOrdersListing(),
    DriverDispatchedOrdersListing(),
    DriverCompletedOrdersListing(),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging().subscribeToTopic('drivers');
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) =>  WillPopScope(
        onWillPop: () => exitApp(context),
        child: Scaffold(
          key: _drawerKey,
          appBar: AppBar(
            leading: IconButton(
              icon: Image.asset(
                "assets/images/home-page-icon.png",
                width: 20, height: 20,
              ),
              onPressed: () {
                _drawerKey.currentState.openDrawer();
              }
            ),

            centerTitle: _currentIndex!=0,
            title: _currentIndex == 0?
              Text(AppData.driver.profile?.name ?? ''):
              Image.asset("assets/images/icon.png", width: 40, height: 40),

            actions: [
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/helpline'),
                icon: Image.asset("assets/images/customer-care.png", width: 20, height: 20)
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed('/notifications'),
                icon: Image.asset("assets/images/notification.png", width: 20, height: 20)
              )
            ],
          ),
          body: tabPages[_currentIndex],
          drawer: DriverDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
              type: BottomNavigationBarType.fixed,
              currentIndex: _currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: lang.newOrders
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.view_list_rounded),
                label: lang.acceptedOrders
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.view_list_rounded),
                  label: lang.dispatchedOrders
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_add_check),
                  label: lang.completedOrders
              )
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade600,
            backgroundColor: Theme.of(context).primaryColor,
            onTap: (index) =>
              setState(() => _currentIndex = index)
          ),
        ),
      ),
    );
  }
}
