import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

openLoadingDialog(BuildContext context, String text) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            content: Row(children: <Widget>[
              SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                      strokeWidth: 1,
                      valueColor: AlwaysStoppedAnimation(Colors.black))),
              SizedBox(width: 10),
              Text(text + "...")
            ]),
          ));
}

openConfirmVehicleInfoChangeDialog(BuildContext context) {
  return AlertDialog(
            title: Text("Warning"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: <Widget>[
                    SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(CupertinoIcons.info)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                          "You have changed vehicle information. Your account will be on hold until verification process is completed!"),
                    )
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      child: Text("Proceed"),
                      onPressed: () {
                        Navigator.pop(context,true);
                      },
                      minWidth: 0,
                      padding: EdgeInsets.only(left: 10),
                    ),
                    SizedBox(width: 20,),
                    MaterialButton(
                      child: Text("Cancel"),
                      onPressed: () {
                        Navigator.pop(context,false);
                      },
                      minWidth: 0,
                      padding: EdgeInsets.only(left: 10, right: 2),
                    ),
                  ],
                ),
              ],
            ),
          );
}
