import 'package:flutter/material.dart';

class StackButton extends StatefulWidget {

  Function onTap;
  String buttonName;
  StackButton({this.onTap,this.buttonName});
  @override
  _StackButtonState createState() => _StackButtonState();
}

class _StackButtonState extends State<StackButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: GestureDetector(
          onTap:widget.onTap ,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).accentColor),
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text(

              widget.buttonName,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ),
      );
  }
}
