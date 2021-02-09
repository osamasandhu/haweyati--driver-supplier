import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:pedantic/pedantic.dart';

Future<dynamic> performLazyTask(
  BuildContext context,
  Future<dynamic> Function() task, {
  String message = 'Please Wait',
  bool persistent = true,
}) async {

  FocusScope.of(context).requestFocus(FocusNode());
  FocusScope.of(context).requestFocus(FocusNode());

  if (persistent) {
    unawaited(openLoadingDialog(context, message));
  } else {
    unawaited(openLoadingDialog(context, message));
  }

  final result = await task();
  if(Navigator.canPop(context))
    Navigator?.of(context)?.pop();

  return result;
}
