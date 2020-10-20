import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';

class NoScrollView extends Scaffold {
  NoScrollView({
    Widget body,
    Widget bottom,
    bool extendBody,
    PreferredSizeWidget appBar = const HaweyatiAppBar()
  }): super(
    body: body,
    appBar: appBar,
    backgroundColor: Colors.white,
    extendBody: extendBody ?? bottom is FlatActionButton,
    bottomNavigationBar: bottom
  );
}
