import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/driver/edit-driver-profile.dart';
import 'package:haweyati_supplier_driver_app/src/driver/orders/driver-all-orders_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/change-password.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-selected-orders_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-data.dart';

class DriverHomePage extends StatefulWidget {
  @override
  _DriverHomePageState createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _currentIndex = 0;

  // DriverModel _driver;
  var _showFab = false;
  final _page1 = DriverAllOrdersPage();
  final _page2 = DriverSelectedOrders();
  // final _page2 = DriverSelectedOrders();
  final _controller = ScrollController();

  final _drawerKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging().subscribeToTopic('drivers');

    // _driver = Hive.box('driver').get(0);
    _controller.addListener(() {
      if (_controller.offset > 100)
        setState(() => _showFab = true);
      else
        setState(() => _showFab = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        centerTitle: _currentIndex == 1,
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
      body: CustomScrollView(slivers: <Widget>[
        SliverToBoxAdapter(child: Container(),),
        _currentIndex == 0 ? _page1 : _page2
      ], controller: _controller),

      drawer: Drawer(child: Container(
        color: Color(0xff313f53),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(child: Column(children: <Widget>[
                Center(child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: AppData.driver.profile.image !=null
                      ? NetworkImage(
                      HaweyatiService.convertImgUrl(AppData.driver.profile.image.name)) :
                 AssetImage("assets/images/icon.png"),
                )),
                SizedBox(height: 15),
                Center(child: Text(AppData?.driver?.profile?.name ?? '', textAlign: TextAlign.center, style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ))),
                Center(child: FlatButton.icon(
                  onPressed: null,
                  icon:Image.asset("assets/images/star.png", width: 20, height: 20),
                  label: Text("Rated 5.0", style: TextStyle(color: Colors.white))
                )),
              ])),
            ),

            SizedBox(height: 10),

            Expanded(child: SingleChildScrollView(
              child: Column(children: <Widget>[
                _buildListTile(
                  title: "Home",
                  icon: Icons.home,
                  onTap: () {
                    Navigator.of(context).pop();
                  }
                ),
                _buildListTile(
                  title: "My Profile",
                  onTap: () {
                    CustomNavigator.navigateTo(context, EditDriverProfile());
                  },
                  icon: Icons.person
                ),
                _buildListTile(
                  title: "Completed Orders",
                  onTap: () {
                    /*CustomNavigator.navigateTo(context, DriverCompletedOrders());*/
                  },
                  icon: Icons.format_list_numbered
                ),
                _buildListTile(
                    title: "Change Password",
                    onTap: () {
                      CustomNavigator.navigateTo(context, ChangePassword());
                    },
                    icon: Icons.lock
                ),
                _buildListTile(
                  title: "Logout",
                  onTap: () async {
                    await AppData.signOut();
                    CustomNavigator.pushReplacement(context, PreSignInPage());
                  },
                  icon: Icons.exit_to_app
                )
              ]),
            ))
          ], crossAxisAlignment: CrossAxisAlignment.start),
        ),
      )),

      floatingActionButton: _showFab ? FloatingActionButton(
        elevation: 5,
        backgroundColor: Colors.white,
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          _controller.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.ease);
        },
      ): null,

      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('All Orders')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check),
            title: Text('Accepted Orders')
          )
        ],

        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildListTile({IconData icon, String title, Function onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,color: Colors.white, size: 30),
      title: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
