import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/widgits/stackButton.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  bool autoValidate = false;
  bool loading = false;
  var _formKey = GlobalKey<FormState>();
  var key = GlobalKey<ScaffoldState>();

  TextEditingController oldPass = new TextEditingController();
  TextEditingController newPass = new TextEditingController();
  TextEditingController confirmPass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       Scaffold(
        key: key,
        appBar: HaweyatiAppBar(actions: [],),
        body: SingleChildScrollView(
          child: Form(key: _formKey,autovalidate: autoValidate, child: SingleChildScrollView(padding: EdgeInsets.fromLTRB(20, 40, 20, 0), child: Column(
              children: <Widget>[
                HaweyatiPasswordField(
                  label: lang.oldPassword,
                  controller: oldPass,
                  validator: (value) {
                    return value.isEmpty ? lang.enterOldPassword : null;
                  },
                  context: context,
                ),
                  SizedBox(height: 15,),
                HaweyatiPasswordField(
                  label: lang.newPassword,
                  controller :newPass,
                  validator: (value) {
                    if(value.length<8)
                      return lang.atLeastEight;
                    return value.isEmpty ? lang.enterNewPassword : null;
                  },
                  context: context,
                ),

                SizedBox(height: 15,),
                HaweyatiPasswordField(
                  label: lang.confirmPassword,
                  controller:confirmPass,
                  validator: (value) {
                    if(value.isEmpty){
                      return lang.confirmPassword;
                    }
                    if(newPass.text!=confirmPass.text){
                      return lang.passwordNotMatched;
                    }
                    return null;
                  },
                  context: context,
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: StackButton(buttonName: lang.changePassword,onTap: () async {

                    if(_formKey.currentState.validate()){
                      FocusScope.of(context).requestFocus(FocusNode());
                      FocusScope.of(context).requestFocus(FocusNode());
                      openLoadingDialog(context, lang.changingPassword);
                      var change = {
                          '_id' : AppData.isDriver ? AppData.driver.profile.id : AppData.supplier.person.id,
                          'old' : oldPass.text,
                          'password' : newPass.text,
                      };
                      var res = await HaweyatiService.patch('persons/update-password', change);
                      try{
                        print(res.data['_id']);
                        Navigator.pop(context);
                        showSimpleSnackbar(key, lang.passwordUpdated,true);
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

            ),)
        ),

        ),
      ),
    );
  }
}
