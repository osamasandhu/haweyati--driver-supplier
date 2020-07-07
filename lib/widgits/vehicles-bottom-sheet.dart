import 'package:flutter/material.dart';

class AddOptionBottomSheet extends StatefulWidget {
  @override
  _AddOptionBottomSheetState createState() => _AddOptionBottomSheetState();
}

class _AddOptionBottomSheetState extends State<AddOptionBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffdadada),
      appBar: AppBar(
        title: Text("Cancel"),
        centerTitle: true,
      ),
      body: ListView(padding: EdgeInsets.only(top: 20),
        children: <Widget>[

          Center(child: Text("Customer Info",style: TextStyle(fontSize: 18),)),
          Container(

            color: Colors.white,
            child:

            ListTile(
              leading: Icon(
                Icons.face,
                size: 30,
              ),
              title: Text(
                "Add Customer",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
              onTap: () {
                print("123");
              },
            ),


          )

////////
          ///
          ,
          SizedBox(
            height: 20,
          ),

          Center(child: Text("Invoice",style: TextStyle(fontSize: 18),)),
          Container(
            color: Colors.white,
            child:
            ListTile(
              leading: Icon(
                Icons.list,
                size: 30,
              ),
              title: Text(
                "Add List Items",
                style: TextStyle(fontSize: 18),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 30,
              ),
              onTap: () {
                print("123");
              },
            ),
          ),

        ],
      ),
    );
  }
}
