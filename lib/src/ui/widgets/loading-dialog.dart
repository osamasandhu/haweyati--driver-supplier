import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';

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
              Expanded(child: Text(text + "..."))
            ]),
          ));
}

openConfirmVehicleInfoChangeDialog(BuildContext context) {
  return LocalizedView(
    builder: (context,lang) =>
     AlertDialog(
              title: Text(lang.warning),
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
                        child: Text(lang.changedVehicleInfo),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
                              textStyle: MaterialStateProperty.all(TextStyle(
                                  color: Theme.of(context).primaryColor
                              ))
                          ),
                          child: Text(lang.proceed,style: TextStyle(color: Theme.of(context).accentColor),),
                          onPressed: () => Navigator.of(context).pop(true)
                      ),
                      TextButton(
                          child: Text(lang.cancel),
                          onPressed: () => Navigator.of(context).pop(false)
                      ),
                      // MaterialButton(
                      //   child: Text(lang.proceed),
                      //   onPressed: () {
                      //     Navigator.pop(context,true);
                      //   },
                      //   minWidth: 0,
                      //   padding: EdgeInsets.only(left: 10),
                      // ),
                      // SizedBox(width: 20,),
                      // MaterialButton(
                      //   child: Text(lang.cancel),
                      //   onPressed: () {
                      //     Navigator.pop(context,false);
                      //   },
                      //   minWidth: 0,
                      //   padding: EdgeInsets.only(left: 10, right: 2),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
  );
}
