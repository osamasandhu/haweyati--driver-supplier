
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSimpleSnackbar(GlobalKey<ScaffoldState> key,String text,[bool error = false]){
  key.currentState.showSnackBar(SnackBar(
    content: Text(text),
    backgroundColor: error ? Colors.red : Colors.black,
    behavior: SnackBarBehavior.fixed,
  ));
}