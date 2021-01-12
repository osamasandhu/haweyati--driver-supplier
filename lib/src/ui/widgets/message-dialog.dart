import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


openMessageDialog(BuildContext context, String text,[int popLength]) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(children: <Widget>[
          Text(text),
          Align(
            alignment: Alignment.topRight,
            child: MaterialButton(child: Text("Ok"),onPressed: (){
              if(popLength!=null){
                for(int i=0; i<popLength; ++i){
                  Navigator.pop(context);
                }
              }
              else {
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