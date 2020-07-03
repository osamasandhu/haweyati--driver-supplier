import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/customNa.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bottomPAges/chat/chat/chat-page.dart';
import 'no-scroll_page.dart';

class HelplinePage extends StatefulWidget {
  @override
  _HelplinePageState createState() => _HelplinePageState();
}

class _HelplinePageState extends State<HelplinePage> {


  void launchWhatsApp(
      {@required String phone,
        @required String message,
      }) async {
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        return "whatsapp://send?   phone=$phone&text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  bool _available;

  @override
  void initState() {
    super.initState();

    _checkAvailability();
  }

  void _checkAvailability() {
    final dateTime = DateTime.now();
    final time = dateTime.hour + (dateTime.minute / 100);

    setState(() => _available = time >= 9 && time < 24);
  }

  @override
  Widget build(BuildContext context) {
    return NoScrollPage(
      appBar: HaweyatiAppBar(),

      icon: Image.asset('assets/images/icons/call-dial.png', width: 20),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: <Widget>[
          Expanded(
            flex: 3,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text("Need Help?", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,color: Color(0xff313f53)
//                color: Theme.of(context).primaryColor
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Text(loremIpsum.substring(0,66), style: TextStyle(
                  fontSize: 14,color: Color(0xff313f53)
//                  color: Theme.of(context).primaryColor
                ), textAlign: TextAlign.center),
              ),
            ], mainAxisAlignment: MainAxisAlignment.end)
          ),
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 6,
            child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Icon(Icons.access_time, size: 50,color: Color(0xff313f53)),
              ),
              Text("9:00 AM - 12:00 PM", style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff313f53)
              )),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _available? Colors.green: Colors.red,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                  Text("${_available? "": "Not"} Available for Call", style: TextStyle(
                    fontSize: 18,
                    color: _available? Colors.green: Colors.red
                  )),
                ], mainAxisAlignment: MainAxisAlignment.center),
              )
            ])
          ),
        ], mainAxisAlignment: MainAxisAlignment.center),
      ),

      action: 'Get Help',
      onAction: _available ?
        () {
          _checkAvailability();
//          if(_available){
//
//            launchWhatsApp(phone:" +923472363720", message: "Hello");
//          }

          if(_available){
            CustomNavigator.navigateTo(context, ChatViewPage());
          }
//          if (_available) launch("tel:+923472363720");
        }:
        null,
    );
  }
}
