import 'routes.dart';
import 'l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HaweyatiBusinessApp extends Theme {
  HaweyatiBusinessApp(String route): super(
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
      // initialRoute: route,
      initialRoute: route,
      localeResolutionCallback: (locale, locales) {
        return locale;
      },

      localizationsDelegates: [
        HaweyatiLocalization.delegate,
        DefaultMaterialLocalizations.delegate
      ],
      supportedLocales: [const Locale('en'), const Locale('ar')],
    )
  );
}
