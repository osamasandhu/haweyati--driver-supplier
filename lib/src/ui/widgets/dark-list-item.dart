import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DarkListItem extends Container {
  DarkListItem({
    String title,
    Widget trailing,
    Function onTap
  }): super(
    decoration: BoxDecoration(
      color: Color(0xfff2f2f2f2),
      borderRadius: BorderRadius.circular(10),
    ),

    child: GestureDetector(
      onTap: onTap,
      child: ListTile(
        title: Text(title),
        trailing: trailing,
      ),
    )
  );
}