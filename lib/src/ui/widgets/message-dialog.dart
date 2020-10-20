import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


openMessageDialog(BuildContext context, String text,[bool popTwoTimes=false]) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(

        content: Column(children: <Widget>[
          Text(text),
          Align(
            alignment: Alignment.topRight,
            child: MaterialButton(child: Text("Ok"),onPressed: (){
              if(popTwoTimes){
                Navigator.pop(context);
                Navigator.pop(context);
              }else {
                Navigator.pop(context);
              }
            },
              minWidth: 0,
            ),
          ),
        ],
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      )
  );
}