import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
class VerificationPhoneNumber extends StatefulWidget {

  @override
  _VerificationPhoneNumberState createState() =>
      _VerificationPhoneNumberState();
}

class _VerificationPhoneNumberState extends State<VerificationPhoneNumber> {
  FocusNode _node = FocusNode();
  TextEditingController phone;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HaweyatiAppBar(context: context,),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
                alignment: Alignment(0, 0.95),
                child: GestureDetector(
                    onTap:(){}
//                        () {
//                      Navigator.of(context).push(
//                          MaterialPageRoute(builder: (context) => OrderPlaced(constructionService: widget.constructionService,)));
//                    },
                    ,child: Text(
                      "Please Wait 0:49 ",
                      style: TextStyle(
                          fontSize: 16, color: Theme.of(context).accentColor),
                    ))),
            Align(
                alignment: Alignment(0, 0.85),
                child: Text(
                  "Didn't receive a code ?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                )),
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Verification",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
                  child: Text(
                    loremIpsum.substring(0,70),
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("+966500303350"),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
      onTap: (){Navigator.of(context).pop();},                  child: Text(
                      "Change",
                      style: TextStyle(color: Theme.of(context).accentColor),
                    ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 15, 70, 100),
                  child: Row(
                    children: <Widget>[

           _buildField(_node),
                      SizedBox(width: 60,)
                    ,  _buildField(null),SizedBox(width: 60,)         ,  _buildField(null),SizedBox(width: 60,)  ,         _buildField(null, true)
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }


  Widget _buildField(FocusNode _node, [bool last = false]){
    return Expanded(
        child: TextFormField(keyboardType: TextInputType.phone,
          obscureText: true,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (String val){
            FocusScope.of(context).nextFocus();
            },
          decoration: InputDecoration(
              hintText: "-",
              hintStyle: TextStyle(fontWeight: FontWeight.bold)),
        ));
  }
}
