import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';

import 'routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HaweyatiBusinessApp extends Theme {
  HaweyatiBusinessApp(): super(
    data: ThemeData(
      fontFamily: "Lato",
      appBarTheme: AppBarTheme(
        color: Color(0xff313f53),
        brightness: Brightness.dark
      ),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                print(states);
                return Color(0xFFFF974D);
              }),
              overlayColor: MaterialStateProperty.all(Color(0x33FFFFFF)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.all(StadiumBorder())
          )
      ),
        dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
      primaryColor: Color(0xff313f53),
      accentColor: Color(0xFFFF974D),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: OutlineInputBorder()
      ),
    ),
    child: CupertinoApp(
      routes: routes,
      title: 'Haweyati Business',

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    )
  );
}
