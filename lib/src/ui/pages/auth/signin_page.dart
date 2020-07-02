import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';

import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool autoValidate = false;
  bool loading = false;
  var _formKey = GlobalKey<FormState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  TextEditingController confirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          if (_formKey.currentState.validate()) {

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Row(children: <Widget>[
                  CircularProgressIndicator(strokeWidth: 2),
                  Text("Please Wait ...")
                ]),
              )
            );

            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            });
          } else {
            setState(() => autoValidate = true);
          }
        },
      ),

      bottomNavigationBar: Container(
        height: 50,
        child: Align(
          alignment: Alignment(0, -1),
          child: GestureDetector(
            child: Text("REGISTER NOW", style: TextStyle(
              color: Theme.of(context).accentColor
            )),
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

                Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                SizedBox(height: 10),

                Text("Please Enter Credentials", style: TextStyle(color: Colors.black54)),
                SizedBox(height: 40),

                HaweyatiTextField(
                  keyboardType: TextInputType.emailAddress,
                  label: "Email",
                  controller: email,
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
                    onTap: () {},
                    child: Text("Forget password?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).accentColor,
                      )
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
