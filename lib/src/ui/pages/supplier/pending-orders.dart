import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/services/available-services_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/person.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/viewAllPendingOrders.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/notifications_page.dart';

import '../../widgets/custom-navigator.dart';
import '../helpline_page.dart';
class PendingOrders extends StatelessWidget {

  ScrollController scrollController = ScrollController();
  final _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return


      Scaffold(
        appBar: AppBar(leading: IconButton(
            icon: Image.asset(
              "assets/images/home-page-icon.png",
              width: 20,
              height: 20,
            ),
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            }
        ),

            centerTitle: true,
            title: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                "assets/images/icon.png",
                width: 40,
                height: 40,
              ),
            ),
            actions: [
              IconButton(
                  icon: Image.asset(
                    "assets/images/customer-care.png",
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () =>
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                          builder: (context) => HelplinePage()))
              ),
              IconButton(
                  icon: Image.asset(
                    "assets/images/notification.png",
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () =>
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => NotificationsPage()))
              )
            ]
        ),
        drawer: Drawer(
          child: Container(
            color: Color(0xff313f53),
            constraints: BoxConstraints.expand(),
            child: Padding(
              padding: EdgeInsets.only(top: MediaQuery
                  .of(context)
                  .padding
                  .top),
              child: Column(children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  //   (){CustomNavigator.navigateTo(context,ProfilePage());},
                  child: Container(child: Column(children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.white,
                        radius: 50,
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                        child: Text(
                            "Arslan Khan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            )
                        )
                    ),
                    Center(
                      child: FlatButton.icon(
                          onPressed: null,
                          icon: Image.asset(
                            "assets/images/star.png",
                            width: 20,
                            height: 20,
                          ),
                          label: Text("Rated 5.0",
                              style: TextStyle(color: Colors.white))
                      ),
                    ),
                  ])),
                ),

                SizedBox(height: 10),

                Expanded(child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    _buildListTile(title: "Home", onTap: () {
                      Navigator.of(context).pop();
                    }, icon: Icons.home),
                    _buildListTile(title: "My Profile", onTap: () {
                      CustomNavigator.navigateTo(context, PersonContact());
                    }, icon: Icons.person),
                    _buildListTile(title: "Materials", onTap: () {
                      CustomNavigator.navigateTo(context, SupplierAvailableServicesPage());
                    }, icon: Icons.business),

                    _buildListTile(title: "Logout", onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (_) => false);
                    }, icon: Icons.exit_to_app),
                  ]),
                ))
              ], crossAxisAlignment: CrossAxisAlignment.start),
            ),
          ),
        ),
        key: _drawerKey,

        body: CustomScrollView(
          controller: scrollController, slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
                  (context, i) =>
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewAllPendingOrders()));
                    },

                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  color: Colors.grey.shade200
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[

                              Container(padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(                        color: Theme.of(context).accentColor,
                                    borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10) )),
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                                  Text("M-3917", style: TextStyle(color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  )),
                                  SizedBox(width: 10),
                                  Text("15 min ago", style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                      color: Colors.white
                                  )),
                                ]),
                              ),

                              SizedBox(height: 15,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text("Pick-up Address"),
                              ),
                              SizedBox(height: 7),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child:   _cupertino(context: context,text: "fnafnafnalfnfa;klnfakslnf"),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: _buildRow(name1: "Construction Dumpster" ,name2: "12 Yard Dumpster "),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,
                          )
                      ),
                    ),
                  ),
              childCount: 10
          ),
          ),
        ],
        ),
      );
  }


  Widget _buildRow({String name1, String name2}) {
    return Row(
      children: <Widget>[

        Text("$name1 :", style: TextStyle(fontWeight: FontWeight.w700),),
        SizedBox(width: 10,),
        Expanded(child: Text(name2)),
      ],
    );
  }


  Widget detail({String text1, String text2, BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(children: <Widget>[


        Expanded(flex: 1,
            child: Text(
              text1, style: TextStyle(fontSize: 14, color: Colors.white),)),
        Expanded(flex: 2,
            child: Text(text2, style: TextStyle(fontSize: 14, color: Theme
                .of(context)
                .accentColor),)),
      ]),
    );
  }

  Widget _buildListTile({IconData icon, String title, Function onTap}) {
    return ListTile(onTap: onTap
      ,
      leading: Icon(icon, color: Colors.white, size: 30,),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }


  Widget _cupertino({BuildContext context, String text}){
    return CupertinoTextField(onTap: () {
      CustomNavigator.navigateTo(context, ViewAllPendingOrders());
    }, readOnly: true,
      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      suffix: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(Icons.map),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      style: TextStyle(color: Colors.grey.shade600),
      controller: TextEditingController(text: text),
    );
  }


}
