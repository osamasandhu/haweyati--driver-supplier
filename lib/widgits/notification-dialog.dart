
import 'package:flutter/material.dart';

openNotificationDialog(BuildContext context, List<String> notification,[bool popTwoTimes=false]) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(notification[0]),
        content: Column(
          children: <Widget>[
            Text(notification[1]),
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