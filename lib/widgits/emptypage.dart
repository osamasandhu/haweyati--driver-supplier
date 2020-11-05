import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Empty extends StatefulWidget {
  @override
  _EmptyState createState() => _EmptyState();
}

class _EmptyState extends State<Empty> {

FirebaseMessaging _firebaseMessaging ;


  TextEditingController title =TextEditingController();
  TextEditingController body =TextEditingController();


  
@override
  void initState() {
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(padding: EdgeInsets.fromLTRB(20, 200, 20, 0),
      child: Column(
        children: <Widget>[

          TextFormField(controller: title, decoration: InputDecoration(labelText: "Title"),),
        SizedBox(height: 15,),  TextFormField(controller: body, decoration: InputDecoration(labelText: "Body"),),
          SizedBox(height: 15,),  RaisedButton(onPressed: () async{

            print(await FirebaseMessaging().getToken());
//print('FireBase $_firebaseMessaging');////////////
            //            Dio().post('$apiUrl/fcm/notification', data: {
//              "notification": {
//                "title": title.text,
//                "body": body.text
//              }
//            }).then((value) {
//              print(value);
//            }).catchError(print);
          },child: Text("Button"),),
        ],
      ),
    ),);
  }
}
