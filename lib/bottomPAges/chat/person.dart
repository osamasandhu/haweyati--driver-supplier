import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/driver-supplier-map.dart';
import 'package:haweyati_supplier_driver_app/src/map-page.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';

import '../../customNa.dart';

class PersonContact extends StatefulWidget {
  @override
  _PersonContactState createState() => _PersonContactState();
}

class _PersonContactState extends State<PersonContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(
        context: context,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
        child: Column(
          children: <Widget>[
            Center(
                child: CircleAvatar(
              radius: 65,
            )),
            SizedBox(
              height: 15,
            ),
            Text(
              "Haroon Cheema",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              title: Text("Account",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
,
            _buildListTile(iconData: Icons.edit,title: "Me",onTap: (){}),
            _buildListTile(title: "Map",onTap: (){

              CustomNavigator.navigateTo(context, MapPage());

            },iconData: Icons.location_on),
            _buildListTile(iconData: Icons.theaters,title: "Theme",onTap: (){}),
            ListTile(
              title: Text("Options",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            )
            ,_buildListTile(iconData: Icons.lock,title: "Privacy Policy",onTap: (){}),
            _buildListTile(iconData: Icons.aspect_ratio,title: "Rate Us",onTap: (){}),
            _buildListTile(iconData: Icons.help,title: "Help",onTap: (){}),

          ],
        ),
      ),
    );

  }
  Widget _buildListTile({String title,IconData iconData,Function onTap}){


    return
    ListTile(
    leading: Icon(iconData),trailing: Icon(Icons.arrow_forward_ios),             title: Text(title,style: TextStyle(fontWeight: FontWeight.w400),),
);

}

}


