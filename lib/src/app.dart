import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';

class HaweyatiBusinessApp extends StatelessWidget {
  final SharedPreferences prefs;
  HaweyatiBusinessApp(this.prefs);
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: "Lato",
        appBarTheme: AppBarTheme(
          color: Color(0xff313f53),
          brightness: Brightness.dark
        ),
        primaryColor: Color(0xff313f53),
        accentColor: Color(0xFFFF974D)
      ),
      child: CupertinoApp(
        localizationsDelegates: [
          DefaultMaterialLocalizations.delegate
        ],
//          locale: context.locale,
//          supportedLocales: context.supportedLocales,
//          localizationsDelegates: context.localizationDelegates,

//        initialRoute: "/select-location",
        initialRoute:  prefs.getString('city') == null ? "/select-location" : "/pre-sign-in"  ,
        routes: routes,
      )
    );
  }
}

