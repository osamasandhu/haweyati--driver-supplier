
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';

Future<bool> exitApp(BuildContext context) async {
  bool confirm = await showDialog(context: context,builder: (context){
    return AlertDialog(
        title: Text("Are you sure you want to exit this application?",style: TextStyle(
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
              child: Text("Yes",style: TextStyle(color: Theme.of(context).accentColor),),
              onPressed: () => Navigator.of(context).pop(true)
          ),
          TextButton(
              child: Text("No"),
              onPressed: () => Navigator.of(context).pop(false)
          ),
        ]
    );
  });
  return confirm ?? false;
}
