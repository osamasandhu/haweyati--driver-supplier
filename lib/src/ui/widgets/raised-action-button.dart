import 'package:flutter/material.dart';
import 'flat-action-button.dart';

class RaisedActionButton extends Material {
  final Icon icon;
  final String label;
  final Function onPressed;

  RaisedActionButton({
    @required this.label,
    this.icon, this.onPressed
  }): assert(label != null), super(
    elevation: 20,
    child: Padding(
      padding: const EdgeInsets.only(top: 20),
      child: FlatActionButton(
        icon: icon,
        label: label,
        onPressed: onPressed,
      )
    )
  );
}