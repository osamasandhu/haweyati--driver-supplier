import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:haweyati_supplier_driver_app/model/driver/driver_model.dart';
import 'package:haweyati_supplier_driver_app/model/supplier/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/supplier-Services.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/supplier/auth-pages/waiting-approval_page.dart';
import 'package:haweyati_supplier_driver_app/utils/fcm-token.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-data.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-utils.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import 'package:haweyati_supplier_driver_app/widgits/round-drop-down-button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';

class DriverSignUpPage extends StatefulWidget {
  final PersonModel person;
  final String phoneNumber;
  DriverSignUpPage({this.phoneNumber,this.person});
  @override
  _DriverSignUpPageState createState() => _DriverSignUpPageState();
}

class _DriverSignUpPageState extends State<DriverSignUpPage> {
  PickedFile _image;
  LocationPickerData _userLocation;

  List<String> vehicleTypes = [
    "Small Truck",
    "Big Truck",
    "Pick up",
    "Car"
  ];

  String selectedType = null;

  final _name = new TextEditingController();
  final _phone = new TextEditingController();
  // final _email = new TextEditingController();
  final _license = new TextEditingController();
  final _password = new TextEditingController();
  bool _isSub = false;
  String shopParentId;
  final _model = new TextEditingController();
  final _vehicleName = new TextEditingController();
  final _identification = new TextEditingController();
  Future<List<SupplierModel>> suppliers;

  var simpleFormKey = GlobalKey<SimpleFormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    suppliers = SupplierServices().getSupplier();
    // initMap();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: HaweyatiAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: SimpleForm(
            key: simpleFormKey,
            onSubmit: () async {
              openLoadingDialog(context, "Signing up");
              final map = Map<String, dynamic>.from({
                'profile' : widget?.person?.id,
                "name": _name.text,
                "email": DateTime.now().toIso8601String(),
                "contact": widget.phoneNumber,
                "password": _password.text,
                "license" : _license.text,
                "latitude" : _userLocation.position.latitude,
                "longitude" : _userLocation.position.longitude,
                "supplier" : shopParentId,
                "vehicleName" : _vehicleName.text,
                "model" : _model.text,
                "type" : selectedType,
                "identificationNo" : _identification.text,
                "city" : _userLocation.city,
                "address" : _userLocation.address
              });

              if (_image != null) {
                map["image"] = await MultipartFile.fromFile(await _image.path);
              }

              var res;
              DriverModel driver;
              try {
                res = await HaweyatiService.post('drivers', FormData.fromMap(map));
                 driver = DriverModel.fromJson(res.data);
              } catch (e) {
                Navigator.pop(context);
                scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(res.toString()),
                ));
                return;
              }
              print(res);

              var user = await HaweyatiService.post('auth/sign-in', {"username" : widget?.person?.username ?? _phone.text , "password" : widget?.person?.password ?? _password.text});
               var token = user.data['access_token'];

              await Utils.setToken(token);
              await FCMService().updateProfileFcmToken();

              await AppData.signIn(driver);
              CustomNavigator.pushReplacement(context, WaitingApproval());

            },
            child:  Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text('Register as Driver', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Text('Enter Required Information'),
                ),

                HaweyatiTextField(
                  label: "Name",
                  controller: _name,
                  icon: Icons.person,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Name" : null;
                  },
                ),
                // SizedBox(height: 15),
                // HaweyatiTextField(
                //   keyboardType: TextInputType.emailAddress,
                //   label: "Email",
                //   controller: _email,
                //   icon: Icons.mail,
                //   validator: (value) {
                //     return value.isEmpty ? "Please Enter Email" : null;
                //   },
                // ),
                SizedBox(height: 15),
             widget.person==null ?   HaweyatiTextField(
                  keyboardType: TextInputType.phone,
                  label: "Phone",
                  controller: _phone,
                  icon: Icons.call,
                  validator: widget.person == null ? (value) {
                    return value.isEmpty ? "Please Enter Phone" : null;
                  } : null,
                ) : SizedBox(),
                SizedBox(height: 15),
                HaweyatiTextField(
                  keyboardType: TextInputType.emailAddress,
                  label: "License Number",
                  controller: _license,
                  icon: Icons.calendar_today,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter License Number" : null;
                  },
                ),
                SizedBox(height: 15),
              widget.person==null ?  HaweyatiPasswordField(
                  label: "Password",
                  controller: _password,
                  validator: widget.person==null ? (value) {
                    return value.isEmpty ? "Please Enter Password" : null;
                  } : null,
                  context: context,
                ) : SizedBox(),

              LocationPickerWidget(
                onChanged: (location){
                  if(location!=null){
                    _userLocation = location;
                  }
                },
              ),

                // Padding(
                //   padding: const EdgeInsets.only(top: 15),
                //   child: DarkContainer(child: Container(height: 100)),
                // ),

                ImagePickerWidget(
                  onImagePicked: (PickedFile file){
                    _image = file;
                  },
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Text('Vehicle Details', style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  )),
                ),

              RoundDropDownButton<String>(
                hint: Text("Vehicle Type"),
                items: vehicleTypes
                    .map((i) => DropdownMenuItem<String>(
                    child: Text(i), value: i))
                    .toList(),
                value: selectedType,
                onChanged: (item) => setState(() {
                  this.selectedType = item;
                  FocusScope.of(context).requestFocus(new FocusNode());
                }),
              ),

                HaweyatiTextField(
                  keyboardType: TextInputType.emailAddress,
                  label: "Vehicle Name",
                  controller: _vehicleName,
                  icon: Icons.call,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Vehicle Name" : null;
                  },
                ),
                SizedBox(height: 15),
                HaweyatiTextField(
                  label: "Model",
                  controller: _model,
                  icon: Icons.airplanemode_active,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Model" : null;
                  },
                ),
                SizedBox(height: 15),
                HaweyatiTextField(
                  label: "Identification",
                  controller: _identification,
                  icon: Icons.airplanemode_active,
                  validator: (value) {
                    return value.isEmpty ? "Please Enter Identification" : null;
                  },
                ),

              Row(children: <Widget>[
                Checkbox(value: _isSub, onChanged: (val) {
                  setState(() => _isSub = val);
                }),
                Text('It is a Sub Branch')
              ]),
              _isSub ?  Container(
                height: 300,
                child: SimpleFutureBuilder.simpler(
                    context: context,
                    future: suppliers,
                    builder: (List<SupplierModel> snapshot) {
                      return ListView.builder(
                          itemCount: snapshot.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(bottom: 30),
                          itemBuilder: (context, index) {
                            var _supplier = snapshot[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: _supplier.person?.image !=null ? NetworkImage(
                                    HaweyatiService.resolveImage(_supplier.person?.image?.name)
                                ) : AssetImage("assets/images/icon.png"),
                              ),
                              title: Text(_supplier.person.name),
                              subtitle: Text(_supplier.location.address ??
                                  'Address not specified'),
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
              ) : SizedBox(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15, top: 30),
                  child: Stack(children: <Widget>[
                    Align(
                      alignment: Alignment(0, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('/driver-sign-in');
                          },
                          child: Text('ALREADY REGISTERED', style: TextStyle(
                            color: Theme.of(context).accentColor
                          )),
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment(1, 0),
                      child: SizedBox(
                        width: 55,
                        height: 55,
                        child: FlatButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: (){
                            simpleFormKey.currentState.submit();
                          },
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          color: Theme.of(context).accentColor,
                          child: Icon(Icons.arrow_forward)
                        ),
                      ),
                    ),


                  ]),
                )
              ])
          ),
        ),
      ),
    );
  }
}
