import 'package:flutter/material.dart';
import 'flat-action-button.dart';

class RaisedActionButton extends Material {
  final Icon icon;
  final String label;
  final Function onPressed;
  final EdgeInsets padding;
  RaisedActionButton({
    @required this.label,
    this.icon, this.onPressed,
    this.padding = const EdgeInsets.only(top: 20)
  }): assert(label != null), super(
    elevation: 20,
    child: Padding(
      padding: padding,
      child: FlatActionButton(
        icon: icon,
        label: label,
        onPressed: onPressed,
      )
    )
  );
}