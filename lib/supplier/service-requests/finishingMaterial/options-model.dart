import 'package:flutter/cupertino.dart';

class Option{
  String title;
  List<OptionValue> optionValues;

  Option({this.title,this.optionValues});
}

List<Option> options = [];


class OptionValue {
  TextEditingController valueController;
  String valueName;

  OptionValue({this.valueName,this.valueController});

}