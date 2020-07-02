import 'package:flutter/material.dart';

class WaitingDialog extends AlertDialog {
  WaitingDialog([String message = "Please Wait ..."]): super(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10)
    ),
    content: Row(children: <Widget>[
      SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),

      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(message),
      )
    ])
  );
}