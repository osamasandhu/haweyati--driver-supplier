import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/profile-image-picker.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/supplier/auth-pages/waiting-approval_page.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import 'package:haweyati_supplier_driver_app/widgits/round-drop-down-button.dart';
import 'package:image_picker/image_picker.dart';

class EditDriverProfile extends StatefulWidget {
  @override
  _EditDriverProfileState createState() => _EditDriverProfileState();
}

class _EditDriverProfileState extends State<EditDriverProfile> {

  PickedFile _image;
  LocationPickerData _userLocation;
  bool isVehicleInfoChanged = false;

  List<String> vehicleTypes = [
    "Small Truck",
    "Big Truck",
    "Pick up",
    "Car"
  ];

  String selectedType = AppData.driver.vehicle.type;

  String imagePath;
  Location location = AppData.driver.location;
  var name = TextEditingController.fromValue(TextEditingValue(text: AppData.driver.profile.name));
//  var email = TextEditingController.fromValue(TextEditingValue(text: HaweyatiData.customer.profile.email));
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
  Widget build(BuildContext context) {
    print("Called");
    return Scaffold(
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
                      print(proceed);
              if(proceed==null || !proceed){
                print("returned");
                return;
              }
              print("working");
            }
              FocusScope.of(context).requestFocus(FocusNode());
              FocusScope.of(context).requestFocus(FocusNode());
              openLoadingDialog(context, 'Updating profile');

              FormData profile = FormData.fromMap({
                "_id" : AppData.driver.sId,
                'person' : AppData.driver.profile.id,
                "name": name.text,
                "license" : _license.text,
                "latitude" : _userLocation.position.latitude,
                "longitude" : _userLocation.position.longitude,
                "vehicleName" : _vehicleName.text,
                "model" : _model.text,
                "type" : selectedType,
                "identificationNo" : _identification.text,
                "city" : _userLocation.city,
                "address" : _userLocation.address,
                'isVehicleInfoChanged' : isVehicleInfoModified()
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
              print(res.data);
              try{
                await AppData.signIn(Driver.fromJson(res.data));
                if(isVehicleInfoChanged){
                  CustomNavigator.pushReplacement(context, WaitingApproval());
                }else{
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
                print(res.data);
              } catch (e){
                Navigator.pop(context);
                key.currentState.hideCurrentSnackBar();
                showSimpleSnackbar(key, res.toString(),true);
              }
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
              validator: (value) => emptyValidator(value, 'Name'),
              label: 'Name',
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
            // ),\
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
                    child: Text("Submit"),
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20.0),
            //   child: RaisedButton(
            //     child: Text("Submit"),
            //     onTap: () async {
            //     print(isVehicleInfoModified());
            //     return;
            //     if(form.currentState.validate()){
            //
            //
            //       FocusScope.of(context).requestFocus(FocusNode());
            //       FocusScope.of(context).requestFocus(FocusNode());
            //       openLoadingDialog(context, 'Updating profile');
            //
            //
            //       final profile = Map<String, dynamic>.from({
            //         "name": name.text,
            //         "license" : _license.text,
            //         "latitude" : _userLocation.position.latitude,
            //         "longitude" : _userLocation.position.longitude,
            //         "vehicleName" : _vehicleName.text,
            //         "model" : _model.text,
            //         "type" : selectedType,
            //         "identificationNo" : _identification.text,
            //         "city" : _userLocation.city,
            //         "address" : _userLocation.address
            //       });
            //
            //       var res = await HaweyatiService.patch('drivers', profile);
            //       Navigator.pop(context);
            //       print(res.data);
            //       return;
            //       try{
            //         // await AppData.signIn(DriverModel.fromJson(res.data));
            //         Navigator.pop(context);
            //         Navigator.pop(context);
            //         print(res.data);
            //       } catch (e){
            //         Navigator.pop(context);
            //         key.currentState.hideCurrentSnackBar();
            //         showSimpleSnackbar(key, res.toString(),true);
            //       }
            //     } else {
            //       setState(() {
            //         autoValidate=true;
            //       });
            //     }
            //   },),
            // )
          ],),
        ),),);
  }
}
