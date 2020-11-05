import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/no-scroll_page.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
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
  bool autoValidate = false;
  var key = GlobalKey<FormState>();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) => NoScrollPage(
          appBar: HaweyatiAppBar(hideHome: true,),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              if(key.currentState.validate()){

                var result = await CustomNavigator.navigateTo(context, OtpPage(phoneNumber: "+966"+phone.text,));
                if(result ?? false){
                  Navigator.pop(context,"+966"+phone.text);
                }

              } else {
                setState(() {
                  autoValidate=true;
                });
              }
            },
            elevation: 0,
            child: Transform.rotate(
                angle: lang.localeName == 'ar' ? 3.14: 0,
                child: Image.asset(NextFeatureIcon, width: 30)
            ),
          ),
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
                    child: HaweyatiPhoneField(
                      controller: phone,
                      label: lang.yourPhone,
                      validator: (value) => phoneValidator(value),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
