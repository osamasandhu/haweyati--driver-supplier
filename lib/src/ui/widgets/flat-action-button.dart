import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlatActionButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final Function onPressed;

  FlatActionButton({
    @required this.label,
    this.icon, this.onPressed
  }): assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(height: 40),
        child: FlatButton(
          onPressed: onPressed,
          shape: StadiumBorder(),
          textColor: Colors.white,
          disabledColor: Colors.grey.shade400,
          color: Theme.of(context).primaryColor,
          child: icon != null ? Row(children: [
            icon, const SizedBox(width: 8.0), Text(label)
          ], mainAxisAlignment: MainAxisAlignment.center) : Text(label),
        ),
      )
    );
  }
}
