import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(),
      body: ListView.separated(
            itemBuilder: (context, i) {
              return ListTile(
                leading: Image.asset("assets/images/notification_thumb.png",height: 40,width: 40,),
title: Text(loremIpsum.substring(0,60)),
         subtitle: Padding(
           padding: const EdgeInsets.only(top: 8),
           child: Text("12:30 PM"),
         ),     );
            },
            separatorBuilder: (context, i) {
              return Divider();
            },
            itemCount: 12)

    );
  }
}
