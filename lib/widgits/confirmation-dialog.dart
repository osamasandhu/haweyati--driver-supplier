import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
final Widget title;
final Widget content;

final String denyButtonText;
final String confirmButtonText;
final ButtonStyle denyButtonStyle;
final ButtonStyle confirmButtonStyle;

ConfirmationDialog({
  this.title,
  this.content,
  this.denyButtonText = 'NO',
  this.denyButtonStyle,
  this.confirmButtonText = 'YES',
  this.confirmButtonStyle,
});

@override
Widget build(BuildContext context) {
  return AlertDialog(
      title: title,
      content: content,

      insetPadding: const EdgeInsets.all(15),
      titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
      contentPadding: const EdgeInsets.all(15),

      actions: [
        TextButton(
            style: denyButtonStyle,
            child: Text(denyButtonText),
            onPressed: () => Navigator.of(context).pop(false)
        ),
        TextButton(
            style: confirmButtonStyle,
            child: Text(confirmButtonText),
            onPressed: () => Navigator.of(context).pop(true)
        )
      ]
  );
}
}
