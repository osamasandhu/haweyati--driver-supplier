import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_supplier_driver_app/model/order-location_model.dart';
import 'package:haweyati_supplier_driver_app/widgits/emptyContainer.dart';
import 'package:http/http.dart' as http;
import 'package:haweyati_supplier_driver_app/model/driver-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/auth-arguments.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../locations-map_page.dart';

class DriverSignUpPage extends StatefulWidget {
  @override
  _DriverSignUpPageState createState() => _DriverSignUpPageState();
}

class _DriverSignUpPageState extends State<DriverSignUpPage> {
  File _image;
  bool loading = false;
  AuthArguments _arguments;
  bool autoValidate = false;
  var _formKey = GlobalKey<FormState>();
  UserLocation userLocaton;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController vehicleName = new TextEditingController();
  TextEditingController licenseNum = new TextEditingController();
  TextEditingController type = new TextEditingController();
  TextEditingController model = new TextEditingController();
  TextEditingController identification = new TextEditingController();
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initMap();
  }

  initMap() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userLocaton = UserLocation(
        city: prefs.getString('city'),
          address: prefs.getString('address'),
          cords: LatLng(
              prefs.getDouble('latitude'), prefs.getDouble('longitude')
          ),
      );
    });
  }

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

    this._arguments =
        ModalRoute.of(context).settings.arguments as AuthArguments;

    return Scaffold(
      appBar: HaweyatiAppBar(
        context: context,
      ),
      body: Form(
        autovalidate: autoValidate,
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 150),
          child: Column(
            children: <Widget>[
              Text("Signup",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 15),
              Text("Please Enter Credentials",
                  style: TextStyle(color: Colors.black54)),
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
                keyboardType: TextInputType.phone,
                label: "Phone",
                controller: phone,
                icon: Icons.call,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Phone" : null;
                },
                context: context,
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                //       keyboardType: TextInputType.emailAddress,
                label: "License Number",
                controller: licenseNum,
                icon: Icons.calendar_today,
                validator: (value) {
                  return value.isEmpty ? "Please Enter License Number" : null;
                },
                context: context,
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                label: "Type",
                controller: type,
                icon: Icons.hourglass_empty,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Type" : null;
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
              EmptyContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "City",
//                          style: boldText,
                        ),
                        FlatButton.icon(
                            onPressed: () async {
                              UserLocation location = await  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyLocationMapPage(
                                    editMode: true,
                                  )));
                              setState(() {
                                userLocaton = location;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).accentColor,
                            ),
                            label: Text(
                              "Edit",
                              style:
                              TextStyle(color: Theme.of(context).accentColor),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).accentColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(prefs?.getString('city') ?? ''),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: getCamera,
                      child: Text("Camera"),
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Theme.of(context).accentColor,
                    ),
                    FlatButton(
                      onPressed: getGallery,
                      child: Text("Gallery"),
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      color: Theme.of(context).accentColor,
                    )
                  ]),
              SizedBox(height: 10),
              Container(
                height: 200.0,
                width: 150,
                child: _image == null
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                width: 2,
                                color: Theme.of(context).accentColor)),
                        child: Center(child: Text('No image selected.')))
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Text("data")
//                    Image.file(
//                      _image, fit: BoxFit.cover,
//                    )
                        ),
              ),
              SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                    height: 1,
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Vehicle Detail",
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.black,
                    height: 1,
                  )),
                ],
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                keyboardType: TextInputType.emailAddress,
                label: "Vehicle Name",
                controller: vehicleName,
                icon: Icons.call,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Vehicle Name" : null;
                },
                context: context,
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                label: "Model",
                controller: model,
                icon: Icons.airplanemode_active,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Model" : null;
                },
                context: context,
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                label: "Identification",
                controller: identification,
                icon: Icons.airplanemode_active,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Identification" : null;
                },
                context: context,
              ),
            ],
          ),
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation.endDocked,
      floatingActionButton:
      FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.arrow_forward),
        onPressed: () async {
          Profile profileModel = Profile
            (
                email: email.text,
                contact: DateTime.now().toIso8601String(),
                password: password.text,
                name: name.text,
                type: 'Driver',
            );

          FormData profileData = FormData.fromMap(profileModel.toJson());

          _image != null
              ? profileData.files.add(MapEntry(
                  'image',
                  await MultipartFile.fromFile(_image.path,
                      filename: DateTime.now().toIso8601String())))
              : print('No image');


          Response profileResponse = await HaweyatiSupplierDriverService.post('persons', profileData);
          String profileId = profileResponse.data['_id'];

          DriverModel driver = DriverModel(
            profileId: profileId,
            status: 'Pending',
            license: licenseNum.text,
            city: prefs.getString('city'),
            vehicle: Vehicle(
              name: vehicleName.text,
              model: model.text,
              identificationNo: identification.text
            ),
          );

          Dio().post('$apiUrl/drivers', data: driver.toJson());

        },
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: Container(
        height: 50,
        child: Align(
          alignment: Alignment(0, -1),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed('/sign-in', arguments: _arguments);
            },
            child: Text("LOGIN WITH EMAIL",
                style: TextStyle(color: Theme.of(context).accentColor)),
          ),
        ),
      ),
    );
  }
}
