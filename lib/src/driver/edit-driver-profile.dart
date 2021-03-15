import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_client_data_models/models/order/vehicle-type.dart';
import 'package:haweyati_client_data_models/models/others/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/vehicle-type-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/utils/lazy_task.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/auth-pages/waiting-approval_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/profile-image-picker.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';

class EditDriverProfile extends StatefulWidget {
  @override
  _EditDriverProfileState createState() => _EditDriverProfileState();
}

class _EditDriverProfileState extends State<EditDriverProfile> {

  Location _userLocation;
  bool isVehicleInfoChanged = false;
  Future<List<VehicleType>> vehicleTypes;
  VehicleType selectedType = AppData.driver.vehicle.type;
  String imagePath;
  Location location = AppData.driver.location;
  var name = TextEditingController.fromValue(TextEditingValue(text: AppData.driver.profile.name));
  var _email = TextEditingController.fromValue(TextEditingValue(text: AppData.driver.profile?.email??''));
  final key = GlobalKey<ScaffoldState>();
  final form = GlobalKey<FormState>();
  bool autoValidate=false;
  var simpleFormKey = GlobalKey<SimpleFormState>();
  final _license = new TextEditingController.fromValue(TextEditingValue(text: AppData.driver.license));
  final _model = new TextEditingController.fromValue(TextEditingValue(text: AppData.driver.vehicle.model));
  final _vehicleName = new TextEditingController.fromValue(TextEditingValue(text: AppData.driver.vehicle.name));
  final _identification = new TextEditingController.fromValue(TextEditingValue(text: AppData.driver.vehicle.identificationNo));

  bool isVehicleInfoModified() {
    if(selectedType != AppData.driver.vehicle.type){
      return true;
    }
    if(_license.text != AppData.driver.license){
      return true;
    }
    if(_model.text != AppData.driver.vehicle.model){
      return true;
    }
    if(_vehicleName.text != AppData.driver.vehicle.name){
      return true;
    }
    if(_identification.text != AppData.driver.vehicle.identificationNo){
      return true;
    }
    return false;
  }


  @override
  void initState() {
    super.initState();
    vehicleTypes = VehicleTypesService().vehicleTypes();
  }

  @override
  Widget build(BuildContext context) {
    print("image : ${imagePath}");
    return LocalizedView(
      builder: (context, lang) =>  Scaffold(
        key: key,
        appBar: HaweyatiAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: SimpleForm(
            key: simpleFormKey,
            onSubmit: () async {
              isVehicleInfoChanged = isVehicleInfoModified();
              if(isVehicleInfoChanged){
                bool proceed = await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => openConfirmVehicleInfoChangeDialog(context));
                if(!proceed ?? true){
                  return;
                }
              }
                FocusScope.of(context).requestFocus(FocusNode());
                FocusScope.of(context).requestFocus(FocusNode());

                await performLazyTask(context, () async {

                  FormData profile = FormData.fromMap({
                    "_id" : AppData.driver.sId,
                    'profile' : AppData.driver.profile.id,
                    "name": name.text,
                    "email" : _email.text,
                    "license" : _license.text,
                    "latitude" : _userLocation.latitude,
                    "longitude" : _userLocation.longitude,
                    "vehicleName" : _vehicleName.text,
                    "model" : _model.text,
                    "type" : selectedType.id,
                    "identificationNo" : _identification.text,
                    "address" : _userLocation.address,
                    'isVehicleInfoChanged' : isVehicleInfoChanged
                  });

                  if(imagePath!=null){
                    profile.files.add(
                        MapEntry(
                            'image', await MultipartFile.fromFile(imagePath)
                        )
                    );
                  }

                  var res = await HaweyatiService.patch('drivers', profile);
                  Navigator.pop(context);
                  try{
                    await AppData.signIn(Driver.fromJson(res.data));
                    if(isVehicleInfoChanged){
                      CustomNavigator.pushReplacement(context, WaitingApproval());
                    }else{
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  } catch (e){
                    Navigator.pop(context);
                    key.currentState.hideCurrentSnackBar();
                    showSimpleSnackbar(key, res.toString(),true);
                  }
                },message: lang.updatingProfile);

            },
            child: Column(children: <Widget>[
              ProfileImagePicker(
                previousImage: AppData.driver?.profile?.image?.name,
                onImagePicked: (String val){
                  setState(() {
                    imagePath = val;
                  });
                },
              ),
              HaweyatiTextField(
                controller: name,
                validator: (value) => emptyValidator(value, lang.name),
                label: lang.name,
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                keyboardType: TextInputType.emailAddress,
                label: "Email",
                controller: _email,
                icon: Icons.mail,
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                keyboardType: TextInputType.text,
                label: lang.licenseNo,
                controller: _license,
                icon: Icons.calendar_today,
                validator: (value) {
                  return value.isEmpty ? lang.validateLicenseNo : null;
                },
              ),
              LocationPickerWidget(
                location: AppData.driver.location,
                onChanged: (location){
                  if(location!=null){
                    _userLocation = location;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Text(lang.vehicleDetails, style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
              ),

              SimpleFutureBuilder.simpler(
                  context: context,
                  future: vehicleTypes,
                  builder: (List<VehicleType> snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.length,
                        padding: EdgeInsets.only(bottom: 30),
                        itemBuilder: (context, index) {
                          VehicleType _type = snapshot[index];
                          return RadioListTile(
                            value: _type.id,
                              groupValue: selectedType.id,
                              title: Text(_type.name),
                            onChanged: (String val) {
                              setState(() {
                                selectedType = snapshot.firstWhere((element) => element.id == val);
                              });
                            },
                            subtitle: Text("Volumetric Weight: " + _type.volumetricWeight.toString()),
                            secondary: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: _type?.image !=null ? NetworkImage(
                                  HaweyatiService.resolveImage(_type?.image?.name)
                              ) : AssetImage("assets/images/icon.png"),
                            ),
                          );
                        });
                  }),

              HaweyatiTextField(
                keyboardType: TextInputType.emailAddress,
                label: lang.vehicleName,
                controller: _vehicleName,
                icon: Icons.call,
                validator: (value) {
                  return value.isEmpty ? lang.validateVehicle : null;
                },
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                label: lang.vehicleModel,
                controller: _model,
                icon: Icons.airplanemode_active,
                validator: (value) {
                  return value.isEmpty ? lang.validateModel : null;
                },
              ),
              SizedBox(height: 15),
              HaweyatiTextField(
                label: lang.identification,
                controller: _identification,
                icon: Icons.airplanemode_active,
                validator: (value) {
                  return value.isEmpty ? lang.validateIdentification : null;
                },
              ),
              SizedBox(height: 15,),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 45),
                    child: FlatButton(
                      onPressed: ()=> simpleFormKey.currentState.submit(),
                      shape: StadiumBorder(),
                      textColor: Colors.white,
                      child: Text(lang.submit),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ],),
          ),),),
    );
  }
}
