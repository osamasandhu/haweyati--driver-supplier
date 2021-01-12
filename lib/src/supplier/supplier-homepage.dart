import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/services/order-service.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/orders/listings/supplier-assigned-orders.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/orders/listings/supplier-dispatched.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/orders/orders-listing.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/fcm-token.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/notification-service.dart';
import 'package:haweyati_supplier_driver_app/widgits/notification-dialog.dart';

import 'orders/listings/supplier-completed-orders-listing.dart';
import 'orders/listings/supplier-pending-orders-listing.dart';
import 'orders/listings/supplier-selected-orders-listing.dart';
import 'profile/supplier-drawer.dart';

class SupplierHomePage extends StatefulWidget {
  @override
  _SupplierHomePageState createState() => _SupplierHomePageState();
}

class _SupplierHomePageState extends State<SupplierHomePage> {
  final _key = GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _controller = ScrollController();

  var _selectedIndex = 0;
  var _scrollToTop = false;

  List<Widget> _children = [
    SupplierPendingOrdersListing(),
    SupplierSelectedOrdersListing(),
    SupplierAssignedOrdersListing(),
    SupplierDispatchedOrdersListing(),
    SupplierCompletedOrdersListing(),
  ];

  // List<Widget> _children = [
  //   OrdersListing(future: OrdersService().supplierAllOrders(),),
  //   OrdersListing(future: OrdersService().supplierSelectedOrders(),),
  //   OrdersListing(future: OrdersService().supplierCompletedOrders(),),
  // ];

  @override
  void initState() {
    super.initState();
    print(AppData.supplier.city);
    FirebaseMessaging().subscribeToTopic('suppliers');
    FCMService().updateProfileFcmToken();
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

  @override Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) =>  WillPopScope(
        onWillPop: () => exitApp(context),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              "assets/images/icon.png",
              width: 40, height: 40,
            ),
            actions: <Widget>[
              IconButton(
                  icon: Image.asset("assets/images/customer-care.png", width: 20, height: 20),
                  onPressed: () => Navigator.of(context).pushNamed('/helpline')
              ),
              IconButton(
                  icon: Image.asset("assets/images/notification.png", width: 20, height: 20),
                  onPressed: () => Navigator.of(context).pushNamed('/notifications')
              )
            ],
            leading: IconButton(
                icon: Image.asset(
                  "assets/images/home-page-icon.png",
                  width: 20,
                  height: 20,
                ),
                onPressed: () {
                  _key.currentState.openDrawer();
                }
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )
            ),

            flexibleSpace: _selectedIndex == 0 ? FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Container(
                padding: const EdgeInsets.only(top: 90, left: 18),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/homepageimage.png'),
                      scale: 3.5, alignment: Alignment(.9, .7)
                  ),
                ),
                child: Column(children: <Widget>[
                  AppData.isSupplier ? Text("${lang.welcome}, " + AppData.supplier.person.name ?? '', style: TextStyle(
                      color: Colors.white, fontSize: 24
                  )) : SizedBox(),
                  SizedBox(height: 30),
                  detail(icon: Icons.format_list_numbered, text1: "Orders", text2: "60", context: context),
                  detail(icon: Icons.star_border, text1: "Rating", text2: "4.5", context: context),
                  detail(icon: Icons.attach_money, text1: "Monthly Income", text2: "120000.00",context: context),
                ], crossAxisAlignment: CrossAxisAlignment.start),
              ),
            ): null
          ),
          key: _key,
          body: NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification notification) {
              if (notification.metrics.pixels > 500) {
                if (!_scrollToTop) setState(() => _scrollToTop = true);
              } else {
                if (_scrollToTop) setState(() => _scrollToTop = false);
              }

              return true;
            },

            child: _children[_selectedIndex],
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
          drawer: SupplierDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: lang.newOrders
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.playlist_add_check),
                    label: lang.acceptedOrders
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.playlist_add_check),
                    label: 'Assigned'
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.playlist_add_check),
                    label: lang.dispatchedOrders
                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.done_outline_rounded),
                    label: lang.completedOrders
                )
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey.shade600,
              backgroundColor: Theme.of(context).primaryColor,
              onTap: (index) {
                setState(() => _selectedIndex = index);
              }
          ),
        ),
      ),
    );
  }
}

Widget detail({String text1, String text2, BuildContext context, IconData icon}) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(children: <Widget>[
        Icon(icon, color: Colors.white, size: 20), SizedBox(width: 10),
        Expanded(flex: 4, child: Text(text1, style: TextStyle(fontSize: 14, color: Colors.white))), SizedBox(width: 25,),
        Expanded(flex: 7, child: Text(text2, style: TextStyle(fontSize: 14, color:Theme.of(context).accentColor))),
      ])
  );
}
