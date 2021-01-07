import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/no-scroll_page.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'ui/pages/otp-page.dart';
import 'ui/widgets/contact-input-field.dart';

class PreSignUpPhoneVerifier extends StatefulWidget {
  final bool forgotPassword;
  PreSignUpPhoneVerifier({this.forgotPassword=false});
  @override
  _PreSignUpPhoneVerifierState createState() => _PreSignUpPhoneVerifierState();
}

class _PreSignUpPhoneVerifierState extends State<PreSignUpPhoneVerifier> {
  bool autoValidate = false;
  var key = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();
  bool isPhoneValid = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) => NoScrollPage(
          appBar: HaweyatiAppBar(hideHome: true,),
          floatingActionButton: FloatingActionButton(
            backgroundColor: !isPhoneValid ? Colors.grey : null,
            onPressed: () async {
              if(isPhoneValid){

                var result = await CustomNavigator.navigateTo(context, OtpPage(phoneNumber: phone.text,));
                if(result ?? false){
                  Navigator.pop(context,phone.text);
                }

              } else {
                showSimpleSnackbar(scaffoldKey, lang.inputValidPhone);
                // setState(() {
                //   autoValidate=true;
                // });
              }
            },
            elevation: 0,
            child: Transform.rotate(
                angle: lang.localeName == 'ar' ? 3.14: 0,
                child: Image.asset(NextFeatureIcon, width: 30)
            ),
          ),
          body: Scaffold(
            key: scaffoldKey,
            body: DottedBackgroundView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    lang.hello,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: Text(
                      "${lang.enterPhoneIntFormat} ${widget.forgotPassword ? lang.resetPassword : lang.registerNow} ",
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
                      child:  ContactInputField((value, status) {
                        phone.text = value;
                        if(status!=isPhoneValid){
                          isPhoneValid = status;
                          setState(() {

                          });
                        }
                      }),
                      // child: HaweyatiPhoneField(
                      //   controller: phone,
                      //   label: lang.yourPhone,
                      //   validator: (value) => phoneValidator(value),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
