import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/sign-in_Model.dart';
import 'package:haweyati_supplier_driver_app/model/static.dart';
import 'package:haweyati_supplier_driver_app/phoneNumber.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/auth-arguments.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/waiting-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';

import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';

class SupplierSignInPage extends StatefulWidget {
  @override
  _SupplierSignInPageState createState() => _SupplierSignInPageState();
}

class _SupplierSignInPageState extends State<SupplierSignInPage> {
  bool loading = false;
  AuthArguments _arguments;
  bool autoValidate = false;
  var _formKey = GlobalKey<FormState>();

  TextEditingController userName = new TextEditingController();
  TextEditingController password = new TextEditingController();

  TextEditingController confirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    this._arguments =
        ModalRoute.of(context).settings.arguments as AuthArguments;

    return Scaffold(
      appBar: HaweyatiAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        foregroundColor: Colors.white,
        child: Icon(Icons.arrow_forward),
        onPressed: () async {
          SigninModel signinModel =
              SigninModel(
                  username: userName.text,
                  password: password.text);
          FormData signData = FormData.fromMap(signinModel.toJson());
print(signinModel.toJson());

          var res = await HaweyatiSupplierDriverService.post(
              'auth/sign-in', signinModel.toJson());
          print(res.data['access_token']);
          var token =res.data['access_token'];
          LocalData.token = token;






//          if (_formKey.currentState.validate()) {
//            showDialog(
//                context: context,
//                builder: (context) =>
//                    WaitingDialog('Signing In, Please wait ...'));
//
//            Future.delayed(Duration(seconds: 2), () {
//              if (this._arguments.isDriver) {
//                Navigator.pushNamedAndRemoveUntil(
//                    context, '/driver-home-page', (route) => false);
//              } else {
//                Navigator.pushNamedAndRemoveUntil(
//                    context, '/', (route) => false);
//              }
//            });
//          } else {
//            setState(() => autoValidate = true);
//          }
        },
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Align(
          alignment: Alignment(0, -1),
          child: GestureDetector(
            onTap: () async {
              Navigator.of(context).pushReplacementNamed('/supplier-sign-up',
                  arguments: _arguments);
            },
            child: Text("REGISTER NOW",
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
        ),
      ),
      body: Form(
        autovalidate: autoValidate,
        key: _formKey,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text("Sign In",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                SizedBox(height: 10),
                Text("Please Enter Credentials",
                    style: TextStyle(color: Colors.black54)),
                SizedBox(height: 40),
                HaweyatiTextField(
                  keyboardType: TextInputType.emailAddress,
                  label: "Email or Phone Number",
                  controller: userName,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Email" : null;
                  },
                  context: context,
                ),
                SizedBox(height: 30),
                HaweyatiPasswordField(
                  label: "Password",
                  controller: password,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Password" : null;
                  },
                  context: context,
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                      onTap: () {
                        CustomNavigator.navigateTo(context, PhoneNumber());
                      },
                      child: Text("Forget password?",
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).accentColor,
                          ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
