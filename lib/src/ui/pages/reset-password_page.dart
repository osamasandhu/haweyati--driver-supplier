import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-appbody.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/widgits/stackButton.dart';
import 'auth/pre-sign-in_page.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phoneNumber;
  ResetPasswordPage({this.phoneNumber});
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {

  bool autoValidate = false;
  bool loading = false;
  var _formKey = GlobalKey<FormState>();
  var key = GlobalKey<ScaffoldState>();

  TextEditingController newPass = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: HaweyatiAppBar(),
      body: HaweyatiAppBody(
        title: "Reset Password",
        detail: "Please choose a strong password with at least 8 characters and a mix of letters (upper and lowercase), numbers and symbols",
        btnName: "Done",
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Form(key: _formKey,
            autovalidate: autoValidate,
            child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(20, 40, 20, 0), child: Column(
          children: <Widget>[

            HaweyatiPasswordField(
              label: "New Password",
              controller :newPass,
              validator: (value) {
                if(value.length<8)
                  return 'Password must be at least 8 characters';
                return value.isEmpty ? "Please Enter New Password" : null;
              },
              context: context,
            ),

            SizedBox(height: 15,),
            HaweyatiPasswordField(
              label: "Confirm Password",
              controller:confirmPass,
              validator: (value) {
                if(value.isEmpty){
                  return 'Please Enter Confirm Password';
                }
                if(newPass.text!=confirmPass.text){
                  return 'New and Confirm Passwords not matched';
                }
                return null;
              },
              context: context,
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: StackButton(buttonName: "Reset",onTap: () async {

                if(_formKey.currentState.validate()){
                  FocusScope.of(context).requestFocus(FocusNode());
                  FocusScope.of(context).requestFocus(FocusNode());
                  openLoadingDialog(context, 'Resetting your password...');
                  var change = {
                    'contact' : widget.phoneNumber,
                    'password' : newPass.text,
                  };
                  var res = await HaweyatiService.post('persons/contact/change-password', change);
                  try{
                    Navigator.pop(context);
                    showSimpleSnackbar(key, "Your password has been changed successfully!");
                    Future.delayed(Duration(seconds: 2),() async {
                      CustomNavigator.pushReplacement(context, PreSignInPage());
                    });
                  } catch (e){
                    Navigator.pop(context);
                    key.currentState.hideCurrentSnackBar();
                    showSimpleSnackbar(key, res.toString(),true);
                  }
                } else {
                  setState(() {
                    autoValidate=true;
                  });
                }
              },),
            )
          ],

        ),)),

      ),
    );
  }
}
