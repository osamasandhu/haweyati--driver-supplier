import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomPAges/chat/chat/chat-listing-page.dart';

class BottomHomeDetail extends StatefulWidget {
  @override
  _BottomHomeDetailState createState() => _BottomHomeDetailState();
}

class _BottomHomeDetailState extends State<BottomHomeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, title: Image.asset("assets/images/icon.png",width: 30,),actions: <Widget>[IconButton(icon: Icon(Icons.message), onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Messages()));})],),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Center(
              child: CircleAvatar(
            radius: 65,
            backgroundColor: Colors.red,
            child: Center(
              child: Text(
                "A",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          )),
          SizedBox(
            height: 20,
          ),

         containerDesign(    child: Column(
            children: <Widget>[

              heading(heading: "Personal Info"),
personalinfo(iconData: Icons.person,title: "Arslan"),
              personalinfo(iconData: Icons.call,title: "0347-2363720"),
              personalinfo(iconData: Icons.location_on,title: "Address"),
            ],
          ),),
          SizedBox(height: 20,),
          containerDesign(
            child: Column(
              children: <Widget>[
                heading(heading: "Construction Dumpster"),
                detail(title: "Product", trailing: "QTY"),
                detail(title: "Product", trailing: "QTY"),
                heading(heading: "Scaffolding"),
                detail(title: "Product", trailing: "QTY"),
                detail(title: "Product", trailing: "QTY"),
                heading(heading: "Building Material"),
                detail(title: "Product", trailing: "QTY"),
                detail(title: "Product", trailing: "QTY"),
                heading(heading: "Finishing Material"),
                detail(title: "Product", trailing: "QTY"),
                detail(title: "Product", trailing: "QTY")
              ],
            ),
          ),

          SizedBox(height: 20,),
          containerDesign(  child:
            Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[ ListTile(
              leading: Text("DROP-OFF   ",        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),trailing:               Icon(Icons.location_on)
              ,
            ),SizedBox(height: 15,),
    ListTile(
      leading: Text("150  Heart Street"     ,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),
      ),
    ),
              GestureDetector(
                onTap:(){},
                child: Container(margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(20)),
                   // margin: EdgeInsets.symmetric(horizontal: 50),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "Accept",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ))),
              )

    ],
            ),
          )
        ],
      ),
    );
  }

  Widget heading({String heading}) {
    return ListTile(
      leading: Text(
        heading,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget detail({String title, String trailing}) {
    return ListTile(
      title: Text(title),
      trailing: Text(trailing),
    );
  }
  Widget personalinfo({IconData iconData ,String title}){
    return ListTile(leading: Icon(iconData,color: Colors.black,),title: Text(title),);
  }

  Widget containerDesign({Widget child}){
    return Container(
       // padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color:Color(0xfff2f2f2f2),boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(20),),child:child
    );
  }
}
