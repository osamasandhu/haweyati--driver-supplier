import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showSuccessToast(String message){
  Fluttertoast.showToast(msg: message,backgroundColor: Colors.green,textColor: Colors.white);
}

showErrorToast(String message){
  Fluttertoast.showToast(msg: message,backgroundColor: Colors.red,textColor: Colors.white,timeInSecForIosWeb: 200);
}