import 'package:flutter/material.dart';

class BottomDriver extends StatefulWidget {
  @override
  _BottomDriverState createState() => _BottomDriverState();
}

class _BottomDriverState extends State<BottomDriver>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff313f53),
        title: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Image.asset(
            "assets/images/icon.png",
            width: 40,
            height: 40,
          ),
        ),
        bottom: TabBar(
          indicatorColor: Theme.of(context).primaryColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.only(bottom: 10),
          labelPadding: EdgeInsets.only(bottom: 20),
          controller: tabController,
          labelColor: Colors.white,
          labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
          tabs: <Widget>[
            Text('Dropoff'),
            Text('Pickup'),
          ],
        ),
      ),
      body: TabBarView(controller: tabController, children: [
   _buildList(),
      _buildList()]),
    );
  }

  Widget _buildList(){

    return ListView.builder(
        itemCount: 30,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              onTap: () {},
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
        });
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
  }
}
