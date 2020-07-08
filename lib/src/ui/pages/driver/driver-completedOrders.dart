import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/haweyatiMaterials.dart';
import 'package:haweyati_supplier_driver_app/bottomPAges/chat/person.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/driver/driver-viewCompletedOrders.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/viewAllPendingOrders.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/viewCompletedOrders.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/supplier/viewallselectedorders.dart';

import '../../../../customNa.dart';
import '../../../../helpline_page.dart';
import '../../../../notification.dart';
class DriverCompletedOrders extends StatelessWidget {

  ScrollController scrollController = ScrollController();
  final _drawerKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return


      Scaffold(
        appBar: AppBar(


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
                              builder: (context) => NotificationPage()))
              )
            ]
        ),

        body: CustomScrollView(
          controller: scrollController, slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
                  (context, i) =>
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => DriverViewAllCompletedOrders()));
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

                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Row(mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, children: <Widget>[
                                  Text("M-3917", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  )),
                                  SizedBox(width: 10),
                                  Text("15 min ago", style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
                                      color: Colors.grey
                                  )),
                                ]),

                                SizedBox(height: 20),

                                CupertinoTextField(
                                  readOnly: true,
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) =>
                                            DriverViewAllCompletedOrders()));
                                  },
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
                                  controller: TextEditingController(
                                      text: "address a ksnlsanf samf ljjl j ckl askl salkf akl fkla fkl sdasd as das d asd as da sd as das d as dasd as d asd "),
                                ),

                                SizedBox(height: 15),

                                _buildRow(name1: "Construction Dumpster",
                                    name2: "12 Yard Dumpster "),
                              ],
                              mainAxisAlignment: MainAxisAlignment.start,
                            ),
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




}
