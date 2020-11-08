import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/no-scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:url_launcher/url_launcher.dart';

class HelplinePage extends StatefulWidget {
  @override
  _HelplinePageState createState() => _HelplinePageState();
}

class _HelplinePageState extends State<HelplinePage> {
  void launchWhatsApp(String phone, String message) async {
    var _url;
    if (Platform.isIOS) {
      _url = 'whatsapp://wa.me/$phone/?text=${Uri.parse(message)}';
    } else {
      _url = 'whatsapp://send?phone=$phone&text=${Uri.parse(message)}';
    }

    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      showDialog(context: context, builder: (context) {
        return AlertDialog(
            content: Text('Whatsapp was not found')
        );
      });
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
    return LocalizedView(
      builder: (context,lang) =>
       NoScrollView(
          appBar: HaweyatiAppBar(hideHome: true),
          body: DottedBackgroundView(
            padding: const EdgeInsets.all(20),
            child: Column(children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(lang.needHelp, style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,color: Color(0xff313f53)
                      )),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 15),
                    //   child: Text(loremIpsum.substring(0, 66),
                    //       style: TextStyle(
                    //           fontSize: 14,
                    //           color: Color(0xFF313F53)
                    //       ),
                    //       textAlign: TextAlign.center
                    //   ),
                    // ),
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
                    Text('9:00 AM - 12:00 PM', style: TextStyle(
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
                        Text("${_available? "": "${lang.not}"} ${lang.availableForCall}", style: TextStyle(
                            fontSize: 18,
                            color: _available? Colors.green: Colors.red
                        )),
                      ], mainAxisAlignment: MainAxisAlignment.center),
                    )
                  ])
              ),
            ], mainAxisAlignment: MainAxisAlignment.center),
          ),

          bottom: FlatActionButton(
              label: lang.getHelp,
              icon: Image.asset(CallDialIcon,
                width: 20,
                height: 20,
              ),
              onPressed: _available ? () {
                _checkAvailability();
                if (_available) {
                  launchWhatsApp('+966500303339', '');
                }
              } : null
          )
      ),
    );
  }
}