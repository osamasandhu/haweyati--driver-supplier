import 'package:flutter/material.dart';

class DarkContainer extends Container {
  DarkContainer({
    Widget child,
    double height,
    double width,
    EdgeInsets margin,
    EdgeInsets padding,
  }): super(
      child: child,
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.hardEdge,

      decoration: BoxDecoration(
          color: Color(0xfff2f2f2f2),
          borderRadius: BorderRadius.circular(8)
      )
  );
}