import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/fcm-token.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';

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

  var _selectedIndex = 0;

  List<Widget> _children = [
    SupplierPendingOrdersListing(),
    SupplierSelectedOrdersListing(),
    SupplierCompletedOrdersListing(),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging().subscribeToTopic('suppliers');
    FCMService().updateProfileFcmToken();
  }

  @override Widget build(BuildContext context) {
    return WillPopScope(
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
                AppData.isSupplier ? Text("Welcome, " + AppData.supplier.person.name ?? '', style: TextStyle(
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
        body: _children[_selectedIndex],
        drawer: SupplierDrawer(),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: 'All Orders'
              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_add_check),
                  label: 'Selected'
              ),

              BottomNavigationBarItem(
                  icon: Icon(Icons.done_outline_rounded),
                  label: 'Completed'
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
