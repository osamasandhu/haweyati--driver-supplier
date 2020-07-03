import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/haweyatiMaterials.dart';
import 'package:haweyati_supplier_driver_app/bottomPAges/chat/bottomHomeDetail/bottomHomeDetail.dart';
import 'package:haweyati_supplier_driver_app/bottomPAges/chat/person.dart';
import 'package:haweyati_supplier_driver_app/customNa.dart';
import 'package:haweyati_supplier_driver_app/notification.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../helpline_page.dart';

class AllOrdersPage extends StatelessWidget {
  final _scrollController = ScrollController();
  final _drawerKey = GlobalKey<ScaffoldState>();
  _launchWhatsapp(String phone) async {
    if (await canLaunch(phone)) {
      await launch('whatsapp://send?phone=$phone');
    } else {
      await launch('https://api.whatsapp.com/send?phone=$phone‬');
//      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold( drawer: Drawer(
      child: Container(
        color: Color(0xff313f53),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(children: <Widget>[
            GestureDetector(
              onTap:(){},
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
                      label: Text("Rated 5.0", style: TextStyle(color: Colors.white))
                  ),
                ),
              ])),
            ),

            SizedBox(height: 10),

            Expanded(child: SingleChildScrollView(
              child: Column(children: <Widget>[
                _buildListTile(title: "Home",onTap: (){Navigator.of(context).pop();},icon: Icons.home),
                _buildListTile(title: "Person",onTap: (){CustomNavigator.navigateTo(context, PersonContact());},icon: Icons.person),

                _buildListTile(title: "Materials",onTap: (){CustomNavigator.navigateTo(context, HaweyatiMaterials());},icon: Icons.business),
                _buildListTile(title: "Logout",onTap: (){Navigator.of(context).pushNamed('/pre-sign-in');},icon: Icons.exit_to_app),
              ]),
            ))
          ], crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ),
    ),
      key: _drawerKey,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.arrow_upward),
          onPressed: () {
            _scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
          }
        ),
      ),

      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(        actions: <Widget>[
            IconButton(
                icon: Image.asset(
                  "assets/images/customer-care.png",
                  width: 20,
                  height: 20,
                ),
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HelplinePage()))
            ),
            IconButton(
                icon: Image.asset(
                  "assets/images/notification.png",
                  width: 20,
                  height: 20,
               ),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NotificationPage()))
            )
          ],
            pinned: true,
            title: Text("Arslan Khan"),
            leading: IconButton(
              icon: Image.asset(
                "assets/images/home-page-icon.png",
                width: 20,
                height: 20,
              ),
              onPressed: () {
                _drawerKey.currentState.openDrawer();
              }
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )
            ),

            flexibleSpace: FlexibleSpaceBar(

              background:Padding(
                padding: const EdgeInsets.only(top: 95),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/homepageimage.png'),
                        fit: BoxFit.scaleDown,
                        alignment: Alignment(1, -0.6)
                    ),
                  ),
                  height: 100,
                  child: Column(children: <Widget>[
                    detail(text1: "Orders", text2: "60", context: context),
                    detail(text1: "Rating", text2: "4.5", context: context),
                    detail(text1: "Monthly Income", text2: "120000.00",context: context),
                  ]),
                ),
              ),
              collapseMode: CollapseMode.pin,
            ),
            expandedHeight: 200,
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context, i) => GestureDetector(
              onTap: () {
//                CustomNavigator.navigateTo(context, ViewAllOrders());
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
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

                        CupertinoTextField(readOnly: true,
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
                          controller: TextEditingController(text: "address a ksnlsanf samf ljjl j ckl askl salkf akl fkla fkl sdasd as das d asd as da sd as das d as dasd as d asd "),
                        ),

                        SizedBox(height: 15),

                        _buildRow(name1: "Construction Dumpster" ,name2: "12 Yard Dumpster "),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  )
                ),
              ),
            ),
            childCount: 10
          )),
          SliverToBoxAdapter(child: SizedBox(height: 60)),
        ],
      ),
    );
  }


  Widget _buildRow({String name1, String name2}) {
    return Row(
      children: <Widget>[

        Text("$name1 :",style: TextStyle(fontWeight: FontWeight.w700),),
        SizedBox(width: 10,),
        Expanded(child: Text(name2)),
      ],
    );
  }

  Widget detail({String text1,String text2,BuildContext context}){

    return   Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row( children: <Widget>[


    Expanded(flex: 1, child: Text(text1,style: TextStyle(fontSize: 14,color: Colors.white),)),
    Expanded(flex: 2, child: Text(text2,style: TextStyle(fontSize: 14,color:Theme.of(context).accentColor),)),
    ] ),
    );
}
  Widget _buildListTile({IconData icon, String title, Function onTap}) {
    return ListTile(onTap: onTap
      ,
      leading: Icon(icon,color: Colors.white,size: 30,),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}