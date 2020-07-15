import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/verification.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';

class PhoneNumber extends StatefulWidget {


  @override
  _PhoneNumberState createState() => _PhoneNumberState();
}

class _PhoneNumberState extends State<PhoneNumber> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>VerificationPhoneNumber(
            )
            )
            );
            },
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30,
          ),
        ),
        body: Stack(fit: StackFit.expand,
          children: <Widget>[


            Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text(
                    "Enter Your Phone Number or Email",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 30, 15, 100),
                  child: HaweyatiTextField(controller: phone,label: "Phone Number or Email ",context: context),
                ),
              ],
            )
          ],
        ));
  }
}
