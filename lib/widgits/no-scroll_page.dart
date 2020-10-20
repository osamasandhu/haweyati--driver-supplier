import 'package:flutter/material.dart';

class NoScrollPage extends StatelessWidget {
  final Widget icon;
  final Widget body;
  final AppBar appBar;
  final String action;
  final Function onAction;
  final bool showButtonBackground;

  NoScrollPage({
    this.icon,
    this.body,
    this.appBar,
    this.action,
    this.onAction,
    this.showButtonBackground = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      appBar: appBar,
      bottomNavigationBar: _resolveButton(context, icon, action, onAction, showButtonBackground),
    );
  }

  static _resolveButton(BuildContext context, Widget icon, String label, Function onPressed, bool flag) {
    if (label != null) {
      if (flag) {
        return Material(elevation: 20, child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
          ),
        ));
      }
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
