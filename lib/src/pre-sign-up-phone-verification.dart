import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'ui/pages/otp-page.dart';
import 'ui/widgets/haweyati-text-field.dart';

class PreSignUpPhoneVerifier extends StatefulWidget {
  final bool forgotPassword;
  PreSignUpPhoneVerifier({this.forgotPassword=false});
  @override
  _PreSignUpPhoneVerifierState createState() => _PreSignUpPhoneVerifierState();
}

class _PreSignUpPhoneVerifierState extends State<PreSignUpPhoneVerifier> {
  static String message;
  bool autoValidate = false;
  var key = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    message = widget.forgotPassword ? 'Reset Your Password' : 'Register';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HaweyatiAppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if(key.currentState.validate()){

              var result = await CustomNavigator.navigateTo(context, OtpPage(phoneNumber: phone.text,));
              if(result ?? false){
                Navigator.pop(context,phone.text);
              }

            } else {
              setState(() {
                autoValidate=true;
              });
            }
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
                  "Hello",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                  child: Text(
                    "Enter Your Phone Number in International Format to $message ",
                    style: TextStyle(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Form(
                  key: key,
                  autovalidate: autoValidate,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 100),
                    child: HaweyatiTextField(
                      validator: (value)=> phoneValidator(value),
                      controller: phone,label: "Phone Number",
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
