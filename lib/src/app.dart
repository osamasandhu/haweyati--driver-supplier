//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-signin_page.dart';
//
//
//class HaweyatiASupplieDriverrApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        debugShowCheckedModeBanner:false,
//        theme: ThemeData(fontFamily: "Lato",
//          appBarTheme: AppBarTheme(
//            brightness: Brightness.dark,
//          ),
//          primaryColor: Color(0xff313f53),
//          accentColor: Color(0xffff974d),
//        ),
//        home: PreSignInPage(),
//    );
//
//  }
//}














import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'routes.dart';
//import 'package:easy_localization/easy_localization.dart';
//import 'package:haweyati/src/ui/pages/features_page.dart';

class HaweyatiBusinessApp extends StatelessWidget {
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

          initialRoute: "/driver-home-page"/*pre-sign-in*/,
          routes: routes,
//        home: FeaturesPage(),
        )
    );
  }
}

