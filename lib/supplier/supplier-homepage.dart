import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/person.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/drawer-item.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/localization-selector.dart';
import 'package:haweyati_supplier_driver_app/supplier/orders/listings/supplier-all-orders-listing.dart';
import 'package:haweyati_supplier_driver_app/supplier/orders/listings/supplier-pending-orders-listing.dart';
import 'package:haweyati_supplier_driver_app/supplier/orders/listings/supplier-selected-orders-listing.dart';
import 'package:haweyati_supplier_driver_app/utils/fcm-token.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';

class SupplierHomePage extends StatefulWidget {
  @override
  _SupplierHomePageState createState() => _SupplierHomePageState();
}

class _SupplierHomePageState extends State<SupplierHomePage> {
  var _scrollToTop = false;
  final _controller = ScrollController();
  final _key = GlobalKey<ScaffoldState>();

  SupplierModel _supplier;
  var _selectedIndex = 0;

  List<double> _scrollPos = [0.0, 0.0, 0.0];
  List<Widget> _children = [
    SupplierAllOrdersListing(),
    SupplierSelectedOrdersListing(),
    SupplierPendingOrdersListing(),
  ];

  @override
  void initState() {
    super.initState();
    FirebaseMessaging().subscribeToTopic('suppliers');
    FCMService().updateProfileFcmToken();
  }

  @override Widget build(BuildContext context) {
    return Scaffold(
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
        child: CustomScrollView(slivers: [
          SliverAppBar(
            pinned: true,
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
                  AppData.isSupplier ? Text(AppData.supplier.person.name ?? '', style: TextStyle(
                      color: Colors.white, fontSize: 24
                  )) : SizedBox(),
                  SizedBox(height: 30),
                  detail(icon: Icons.format_list_numbered, text1: "Orders", text2: "60", context: context),
                  detail(icon: Icons.star_border, text1: "Rating", text2: "4.5", context: context),
                  detail(icon: Icons.attach_money, text1: "Monthly Income", text2: "120000.00",context: context),
                ], crossAxisAlignment: CrossAxisAlignment.start),
              ),
            ): null,
            expandedHeight: _selectedIndex == 0 ? 220 : null,
          ),

          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              sliver: _children[_selectedIndex]
          ),

        ], controller: _controller),
      ),

      drawer: Drawer(child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Color(0xff313f53),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: LocalizationSelector(
              selected: Locale('en'),
              onChanged: (locale) {},
            ),
          ),
          Center(child: CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 70),
            backgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.grey.shade600,
          )),
          SizedBox(height: 15),
          Center(child: Text(_supplier?.person?.name ?? '', style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ))),
//          FlatButton.icon(
//            onPressed: , icon: null, label: null)
//
//          GestureDetector(
//            onTap:() {},
//            child: Column(children: <Widget>[
//              Center(
//                child: FlatButton.icon(
//                    onPressed: null,
//                    icon: Image.asset(
//                      "assets/images/star.png",
//                      width: 20,
//                      height: 20,
//                    ),
//                    label: Text("Rated 5.0", style: TextStyle(color: Colors.white))
//                ),
//              ),
//            ]),
//          ),

          SizedBox(height: 10),

          Expanded(child: SingleChildScrollView(child: Column(children: <Widget>[
            DrawerItem(icon: CupertinoIcons.home, text: 'Home', onTap: () => Navigator.of(context).pop()),
            DrawerItem(icon: CupertinoIcons.person, text: 'Account', onTap: () {
              CustomNavigator.navigateTo(context, PersonContact());
            }
            ),
            // DrawerItem(icon: Icons.monetization_on, text: 'Completed Orders', onTap: () => Navigator.of(context).pop()),

            DrawerItem(
                text: 'Service Requests',
                icon: Icons.business,
                onTap: () async {
                  await Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/supplier-services');
                }
            ),
            DrawerItem(icon: Icons.star, text: 'Rate App', onTap: () => Navigator.of(context).pop()),

            // DrawerItem(icon: CupertinoIcons.news, text: 'Reports', onTap: () => Navigator.of(context).pop()),
            // DrawerItem(icon: CupertinoIcons.car, text: 'Driver', onTap: () => Navigator.of(context).pop()),
            DrawerItem(
                text: 'Logout',
                icon: Icons.exit_to_app,
                onTap: () async {
                  await AppData.signOut();
                  CustomNavigator.pushReplacement(context, PreSignInPage());
                }
            ),
          ]))),
        ], crossAxisAlignment: CrossAxisAlignment.start),
      )),

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
            _scrollPos[_selectedIndex] = _controller.position.pixels;
            setState(() => _selectedIndex = index);
            _controller.jumpTo(_scrollPos[_selectedIndex]);
          }
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
