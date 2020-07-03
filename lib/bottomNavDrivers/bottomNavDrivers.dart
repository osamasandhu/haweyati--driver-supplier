import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomPAges/chat/bottomHomeDetail/bottomHomeDetail.dart';


class BottomNavigationSupplier extends StatefulWidget {
  @override
  _BottomNavigationSupplierState createState() => _BottomNavigationSupplierState();
}

class _BottomNavigationSupplierState extends State<BottomNavigationSupplier>
    with SingleTickerProviderStateMixin {


  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String address;
  static List<String> languages = ['English','Arabic',];
  //String selectedLanguage = LocalData.currentLng;





  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { Navigator.of(context).pop();},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Warning",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
      content: Text("This Functionality will be available after Supplier App is develop."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //getAddress();

  }
//
//  getAddress() async {
//    final prefs = await SharedPreferences.getInstance();
//    setState(() {
//      address = prefs.getString('address');
//    });
//  }




  @override
  void dispose() {
    super.dispose();
    //_tabController.dispose();
  }
//
//  int _selectedIndex = 0;
//  TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//  List<Widget> _widgetOptions = <Widget>[
//    BottomHome(),
//
//    BottomDriver(),
//HaweyatiMaterials(),
////    Messages(),
//
//    PersonContact(),    ];
//
//  void _onItemTapped(int index) {
//    setState(() {
//      _selectedIndex = index;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _drawerKey,
      appBar: AppBar(
        leading: IconButton(
            icon: Image.asset(
              "assets/images/home-page-icon.png",
              width: 20,
              height: 20,
            ),
            onPressed: () {
              _drawerKey.currentState.openDrawer();
            }),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff313f53),
          constraints: BoxConstraints.expand(),
          child: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(children: <Widget>[
              SizedBox(height: 10),

              Expanded(child: SingleChildScrollView(
                child: Column(children: <Widget>[
                ]),
              ))
            ], crossAxisAlignment: CrossAxisAlignment.start),
          ),
        ),
      ),

      body:ListView.builder(
          itemCount: 30,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomHomeDetail()));},
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            leading: Text("M-3917"),
                            title: Padding(
                              padding: const EdgeInsets.all(0),
                              child: FlatButton.icon(
                                  onPressed: () {},
                                  icon: Icon(Icons.home),
                                  label: Text("Al Kabi Store ")),
                            ),
                            trailing: Text("15 min ago "),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.location_on,
                                color: Colors.red,
                              ),
                              label: Text("address"),
                            ),
                          ),
                          _builRow(
                              name1: "Construction Dumpster",
                              name2: "Building Material"),
                          SizedBox(
                            height: 5,
                          ),
                          _builRow(
                              name1: "Finishing Material",
                              name2: "Scaffolding"),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    )),
              ),
            );
          }),);
  }

  Widget _buildListTile(String imgPath, String title,Function onTap) {
    return ListTile(onTap: onTap,dense: true,
      leading: Image.asset(
        imgPath,
        width: 20,
        height: 30,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildContainer(
      {String title, Color color, String imgPath, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        //       margin: EdgeInsets.only(bottom: 1),
        height: 120,
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(imgPath),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
//      ),
    );
  }

  Widget _builRow({String name1, String name2}) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(name1),
          flex: 1,
        ),
        Expanded(
          child: Text(name2),
          flex: 1,
        ),
      ],
    );
  }}




