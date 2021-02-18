import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-completed.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-accepted.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-dispatched.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/services/hyper-track_service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/notification-service.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/notification-dialog.dart';

import 'orders/driver-pending.dart';
import 'profile/driver-drawer.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _currentIndex = 0;
  var _scrollToTop = false;
  final _controller = ScrollController();


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

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    super.initState();
    FirebaseMessaging().subscribeToTopic('drivers');
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) NotificationService.iOS_Permission();

    _firebaseMessaging.configure(
//      onBackgroundMessage: myBackgroundMessageHandler,
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        openNotificationDialog(context, NotificationService.transformNotificationMessage(message));
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        openNotificationDialog(context,NotificationService.transformNotificationMessage(message));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        openNotificationDialog(context, NotificationService.transformNotificationMessage(message));
      },
//
    );
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
              SimpleFutureBuilder.simpler(
                context: context,
                future: HyperTrackService.sdk.isRunning(),
                builder:(bool val) => IconButton(
                    onPressed: () async {
                     bool confirmed = await showDialog(context: context,builder: (ctx) {
                        return ConfirmationDialog(
                          title: Text("Are you sure you want to ${val? 'disable' : 'enable'} live tracking?"),
                        );
                      });
                     if(confirmed ?? false)
                     val ?  await HyperTrackService.sdk.stop() :await HyperTrackService.sdk.start();
                   setState(() {});
                    },
                    icon: Icon(val ? Icons.check_circle : Icons.remove_circle,color : val ? Colors.green : Colors.red,)
                ),
              ),
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
          body: NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification notification) {
              if (notification.metrics.pixels > 500) {
                if (!_scrollToTop) setState(() => _scrollToTop = true);
              } else {
                if (_scrollToTop) setState(() => _scrollToTop = false);
              }

              return true;
            },

            child: tabPages[_currentIndex],
          ),
          floatingActionButton: _scrollToTop ? FloatingActionButton(
            elevation: 8,
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey.shade600,
            child: Icon(Icons.arrow_upward),
            onPressed: () async {
              setState(() => _scrollToTop = false);
              await _controller.animateTo(0, duration: Duration(seconds: 1), curve: Curves.ease);
            },
          ) : null,
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
                label: "Assigned"
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
