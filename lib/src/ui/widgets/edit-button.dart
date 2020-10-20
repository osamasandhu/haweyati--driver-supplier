import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';

class EditButton extends StatelessWidget {
  final Function onPressed;
  EditButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Wrap(children: [
        Image.asset(PenIcon, width: 15),
        Text('  Edit', style: TextStyle(color: Theme.of(context).primaryColor))
      ]),
    );
  }
}
