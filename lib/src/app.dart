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
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder()
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
