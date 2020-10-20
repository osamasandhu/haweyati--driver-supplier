import 'package:flutter/material.dart';

class NoScrollPage extends StatelessWidget {
  final Widget icon;
  final Widget body;
  final Widget appBar;
  final String action;
  final bool extendBody;
  final Function onAction;

  NoScrollPage({
    this.icon,
    this.body,
    this.appBar,
    this.action,
    this.onAction,
    this.extendBody = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: appBar,
      extendBody: extendBody,
      backgroundColor: Colors.white,
      bottomNavigationBar: _resolveButton(context, icon, action, onAction),
    );
  }

  static _resolveButton(BuildContext context, Widget icon, String label, Function onPressed) {
    if (label != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(height: 45),
          child: icon != null ? FlatButton.icon(
            icon: icon,
            label: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            textColor: Colors.white,
            disabledColor: Colors.grey.shade400,
            color: Theme.of(context).accentColor,
            onPressed: onPressed,
            shape: StadiumBorder(),
          ) : FlatButton(
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: onPressed,
            textColor: Colors.white,
            disabledColor: Colors.grey.shade400,
            color: Theme.of(context).accentColor,
            shape: StadiumBorder(),
          ),
        ),
      );
    }

    return null;
  }
}
