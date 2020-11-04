import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';

Future<bool> exitApp(BuildContext context) async {
  bool confirm = await showDialog(context: context,builder: (context){
    return AlertDialog(
        title: Text(AppLocalizations.of(context).exitApp,style: TextStyle(
          fontSize: 18
        ),),
        insetPadding: const EdgeInsets.all(15),
        titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        contentPadding: const EdgeInsets.all(15),
        actions: [
          TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  textStyle: MaterialStateProperty.all(TextStyle(
                      color: Theme.of(context).primaryColor
                  ))
              ),
              child: Text(AppLocalizations.of(context).yes,style: TextStyle(color: Theme.of(context).accentColor),),
              onPressed: () => Navigator.of(context).pop(true)
          ),
          TextButton(
              child: Text(AppLocalizations.of(context).no),
              onPressed: () => Navigator.of(context).pop(false)
          ),
        ]
    );
  });
  return confirm ?? false;
}
