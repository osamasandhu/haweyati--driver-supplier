import 'package:flutter/material.dart';

class DrawerItem extends ListTile {
  DrawerItem({IconData icon, String text, Function onTap}): super(
    dense: true, onTap: onTap,
    leading: Icon(icon, size: 24, color: Colors.white),
    title: Text(text, style: TextStyle(color: Colors.white))
  );
}