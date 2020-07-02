import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool autoValidate = false;
  bool loading = false;
  var _formKey = GlobalKey<FormState>();

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController vehicle = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(context: context,),
      body: Form(
        autovalidate: autoValidate,
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 150),
          child: Column(
            children: <Widget>[
              Text("Signup", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 15),
              Text("Please Enter Credentials", style: TextStyle(color: Colors.black54)),
              SizedBox(height: 15),

              HaweyatiTextField(
                label: "Name",
                controller: name,
                icon: Icons.person,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Name" : null;
                },
                context: context,
              ),

              SizedBox(height: 15),

              HaweyatiTextField(
                keyboardType: TextInputType.emailAddress,
                label: "Email",
                controller: email,
                icon: Icons.mail,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Email" : null;
                },
                context: context,
              ),

              SizedBox(height: 15),

              HaweyatiTextField(
                keyboardType: TextInputType.emailAddress,
                label: "Phone",
                controller: phone,
                icon: Icons.call,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Phone" : null;
                },
                context: context,
              ),

              SizedBox(height: 15),

              HaweyatiPasswordField(
                label: "Password",
                controller: password,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Password" : null;
                },
                context: context,
              ),

              SizedBox(height: 15),

              HaweyatiTextField(
                keyboardType: TextInputType.emailAddress,
                label: "Vehicle",
                controller: vehicle,
                icon: Icons.train,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Vehicle" : null;
                },
                context: context,
              ),

//              SizedBox(height: 20,),
//              GestureDetector(onTap: (){                  if (_formKey.currentState.validate()) {
//                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNavigationDriver()));
//              } else {
//                setState(() {
//                  autoValidate = true;
//                });
//              }
//              },
//                child: Container(
//                    decoration: BoxDecoration(
//                        color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(20)),
//                    margin: EdgeInsets.symmetric(horizontal: 50),
//                    child: Center(
//                        child: Padding(
//                          padding: const EdgeInsets.symmetric(vertical: 15),
//                          child: Text(
//                            "REGISTER",
//                            style: TextStyle(
//                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
//                          ),
//                        ))),
//              ),
//              SizedBox(height: 20,),
//              FlatButton(
//                child: Text(
//                  "Login",
//                  style: TextStyle(color: Colors.grey),
//                ),
//                onPressed: () {
//                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage())); },
//              )
            ],
          ),
        ),
      ),

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
            child: Text("LOGIN WITH EMAIL", style: TextStyle(
                color: Theme.of(context).accentColor
            )),
          ),
        ),
      ),
    );
  }
}
