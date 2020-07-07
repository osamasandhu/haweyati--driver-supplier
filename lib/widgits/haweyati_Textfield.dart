import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HaweyatiTextField extends TextFormField {
  HaweyatiTextField({
    int maxlines,
    IconData icon,
    String label,
    TextInputType keyboardType,
    BuildContext context,
    TextEditingController controller,
    Function(String) validator
  })
      :
        super(
    keyboardType: keyboardType,
    textInputAction: TextInputAction.next,
    onFieldSubmitted: (v) {
      FocusScope.of(context).nextFocus();
    },
    style: TextStyle(
      color: Colors.black,
    ),
    scrollPadding: EdgeInsets.all(180),
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.black, width: 5)
      ),
      labelText: label,
      contentPadding: EdgeInsets.all(20),
    ),
    validator: validator,
    controller: controller,
  );
}


class HaweyatiPasswordField extends StatefulWidget {
  final IconData icon;
  final String label;
  final TextInputType keyboardType;
  final BuildContext context;
  final TextEditingController controller;
  final Function(String) validator;

  HaweyatiPasswordField({
    this.icon,
    this.label,
    this.keyboardType,
    this.context,
    this.controller,
    this.validator,
  });

  @override
  _HaweyatiPasswordFieldState createState() => _HaweyatiPasswordFieldState();
}

class _HaweyatiPasswordFieldState extends State<HaweyatiPasswordField> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _show,
      keyboardType: widget.keyboardType,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (v) {
        FocusScope.of(context).nextFocus();
      },
      style: TextStyle(
        color: Colors.black,
      ),
      scrollPadding: EdgeInsets.all(180),
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.black, width: 5)
          ),
          labelText: widget.label,
          focusColor: Theme.of(context).primaryColor,
          contentPadding: EdgeInsets.all(20),
          suffix: GestureDetector(
            child: Text(_show ? "Show": "Hide", style: TextStyle(color: Theme.of(context).primaryColor)),
            onTap: () => setState(() => _show = !_show),
          )
      ),
      validator: widget.validator,
      controller: widget.controller,
    );
  }
}






//class HaweyatiTextField extends Padding {
//  HaweyatiTextField(
//      )
//      : super(
//          padding: EdgeInsets.all(10),
//          child: TextFormField(
//
//          ),
//        );
//}
