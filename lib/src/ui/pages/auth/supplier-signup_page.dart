import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:haweyati_supplier_driver_app/model/location-Model.dart';
import 'package:haweyati_supplier_driver_app/model/order-location_model.dart';
import 'package:haweyati_supplier_driver_app/model/supplier-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/services/supplier-Services.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/auth-arguments.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/emptyContainer.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../locations-map_page.dart';

class SupplierSignUpPage extends StatefulWidget {
  @override
  _SupplierSignUpPageState createState() => _SupplierSignUpPageState();
}

class _SupplierSignUpPageState extends State<SupplierSignUpPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  File _image;
  bool loading = false;
  AuthArguments _arguments;
  bool autoValidate = false;
  var _formKey = GlobalKey<FormState>();
  String shopParentId;
  String groupValue;
  List<String> selectedServices = [];
  bool check = false;
  bool check5 = false;
  bool check1 = false;
  bool check2 = false;
  bool check3 = false;

  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController phone = new TextEditingController();
 // TextEditingController city = new TextEditingController();
  TextEditingController address = new TextEditingController();
 // TextEditingController location = new TextEditingController();
  SharedPreferences prefs;
  UserLocation userLocation;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    initMap();
    suppliers = SupplierServices().getSupplier();
  }

  initMap() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userLocation = UserLocation(
        city: prefs.getString('city'),
        address: prefs.getString('address'),
        cords: LatLng(
            prefs.getDouble('latitude'), prefs.getDouble('longitude')
        ),
      );
    });
  }

  Color selectedColor;
  Future<List<SupplierModel>> suppliers;

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
      key: scaffoldKey,
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
//              SizedBox(height: 15),
//              HaweyatiTextField(
//                label: "City",
//                controller: city,
//                icon: Icons.location_city,
//                validator: (value) {
//                  return value.isEmpty ? "Please Enter City" : null;
//                },
//                context: context,
//              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                label: "Address",
                controller: address,
                icon: Icons.add_location,
                validator: (value) {
                  return value.isEmpty ? "Please Enter Address" : null;
                },
                context: context,
              ),

//              SizedBox(height: 15),
//              HaweyatiTextField(
//                label: "Location",
//                controller: location,
//                icon: Icons.location_on,
//                validator: (value) {
//                  return value.isEmpty ? "Please Enter Location" : null;
//                },
//                context: context,
//              ),
              SizedBox(
                height: 12,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Services",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              CheckboxListTile(
                dense: true,
                value: check,
                onChanged: (val) {
                  setState(() {
                    check = val;
                  });
                },
                title: Text("Construction Dumpster"),
              ),
              SizedBox(
                height: 12,
              ),
              CheckboxListTile(
                dense: true,
                value: check1,
                onChanged: (val1) {
                  setState(() {
                    check1 = val1;
                  });
                },
                title: Text("Scaffolding"),
              ),
              SizedBox(
                height: 12,
              ),
              CheckboxListTile(
                dense: true,
                value: check2,
                onChanged: (val2) {
                  setState(() {
                    check2 = val2;
                    print(val2);
                  });
                },
                title: Text("Building Material"),
              ),
              SizedBox(
                height: 12,
              ),
              CheckboxListTile(
                dense: true,
                value: check3,
                onChanged: (val3) {
                  setState(() {
                    check3 = val3;
                  });
                },
                title: Text("Finishing Material"),
              ),
              SizedBox(
                height: 12,
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
                                userLocation = location;
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
                        child: Image.file(
                          _image,
                          fit: BoxFit.cover,
                        )),
              ),
              SizedBox(height: 15),
              CheckboxListTile(
                  title: Text("Is SubBranch"),
                  dense: true,
                  value: check5,
                  onChanged: (val5) {
                    setState(() {
                      check5 = val5;
                    });
                  }),
              check5
                  ? Container(
                      height: 300,
                        child: SimpleFutureBuilder.simpler(
                            context: context,
                            future: suppliers,
                            builder:
                                (AsyncSnapshot<List<SupplierModel>> snapshot) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 30),
                                  itemBuilder: (context, index) {
                                    var _supplier = snapshot.data[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                            "http://192.168.1.104:4000/uploads/${_supplier.images[0].name}"),
                                      ),
                                      title: Text(_supplier.name),
                                      subtitle: Text(_supplier.address ?? 'Address not specified'),
                                      trailing: Radio(
                                          value: _supplier.sId,
                                          groupValue: shopParentId,
                                          onChanged: (val) {
                                            setState(() {
                                              shopParentId = val;
                                            });
                                            print(shopParentId);
                                          }),
                                    );
                                  });
                            }),
                    )
                  : Container()
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        child: Icon(Icons.arrow_forward),
        onPressed: () async {
          selectedServices.clear();
          if (check) selectedServices.add('Construction Dumpster');
          if (check1) selectedServices.add('Scaffolding');
          if (check2) selectedServices.add('Building Material');
          if (check3) selectedServices.add('Finishing Material');

          if (check5 && shopParentId == null) {
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Please Select Branch"),
            ));
            return  print("You Are Submitting without Branch");
          }
          SupplierModel supplier = SupplierModel(
            name: name.text,
            city: userLocation.city,
            contact: phone.text,
            password: password.text,
            email: email.text,
            locationModel: LocationModel(
              lat: userLocation.cords.latitude,
              lng: userLocation.cords.longitude
            ),
            services: selectedServices,
            shopParentId: shopParentId,
              address: userLocation.address,

//            locationModel: location.text

          );
          print(supplier.shopParentId);

          FormData supplierData = FormData.fromMap(supplier.toJson());

          _image != null
              ? supplierData.files.add(MapEntry(
                  'images',
                  await MultipartFile.fromFile(_image.path,
                      filename: DateTime.now().toIso8601String())))
              : print('No image');

          HaweyatiSupplierDriverService.post('suppliers', supplierData);
//
//          if (_formKey.currentState.validate()) {
//            showDialog(
//                context: context,
//                builder: (context) => AlertDialog(
//                      content: Row(children: <Widget>[
//                        CircularProgressIndicator(strokeWidth: 2),
//                        SizedBox(
//                          width: 4,
//                        ),
//                        Text("Submitting your form")
//                      ]),
//                    ));
//
//            Future.delayed(Duration(seconds: 2), () {
//              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//            });
//          } else {
//            setState(() => autoValidate = true);
//          }
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

class User {
  String firstName;
  String lastName;

  static List<User> getUsers() {
    return [];
  }
}
//"http://192.168.1.104:4000/uploads/${_supplier.images[index].name}"
