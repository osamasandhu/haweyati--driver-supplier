import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';

class DottedBackgroundView extends Container {
  DottedBackgroundView({
    @required Widget child,
    EdgeInsets padding
  }): super(
    child: child,
    padding: padding,
    constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
      color: Colors.white,
      image: DecorationImage(
        fit: BoxFit.fitWidth,
        alignment: Alignment(0, 1),
        image: AssetImage(Pattern)
      )
    )
  );
}
