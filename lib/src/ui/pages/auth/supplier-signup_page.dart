import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/auth-arguments.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';

class SupplierSignUpPage extends StatefulWidget {
  @override
  _SupplierSignUpPageState createState() => _SupplierSignUpPageState();
}

class _SupplierSignUpPageState extends State<SupplierSignUpPage> {
  File _image; bool loading = false;
  AuthArguments _arguments;
  bool autoValidate = false;
  var _formKey = GlobalKey<FormState>();

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController city = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController location = new TextEditingController();


  @override
  Widget build(BuildContext context) {

    Future getCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
      });
    }

    Future getGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
      });
    }

    this._arguments = ModalRoute.of(context).settings.arguments as AuthArguments;

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
                label: "City",
                controller:city,
                icon: Icons.location_city,
                validator: (value) {
                  return value.isEmpty ? "Please Enter City" : null;
                },
                context: context,
              ),

              SizedBox(height: 15),

              HaweyatiTextField(
                label: "Address",
                controller:address,
                icon: Icons.add_location,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Address" : null;
                },
                context: context,
              ),
              SizedBox(height: 15),

              HaweyatiTextField(
                label: "Location",
                controller:location,
                icon: Icons.location_on,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Location" : null;
                },
                context: context,
              ),


              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: getCamera,
                      child: Text("Camera"),
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                    FlatButton(
                      onPressed: getGallery,
                      child: Text("Gallery"),
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Theme
                          .of(context)
                          .accentColor,
                    )
                  ]
              ),
              SizedBox(height: 10),
              Container(
                height: 200.0,
                width: 150,
                child: _image == null ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Theme
                            .of(context)
                            .accentColor)),
                    child: Center(child: Text('No image selected.')))
                    : ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      _image, fit: BoxFit.cover,
                    )
                ),
              ),


              SizedBox(height: 15),


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
        child: Icon(Icons.arrow_forward),
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
        foregroundColor: Colors.white,
      ),

      bottomNavigationBar: Container(
        height: 50,
        child: Align(
          alignment: Alignment(0, -1),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/sign-in', arguments: _arguments);
            },
            child: Text("LOGIN WITH EMAIL", style: TextStyle(
              color: Theme.of(context).accentColor
            )),
          ),
        ),
      ),
    );
  }
}
