import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import 'package:haweyati_supplier_driver_app/widgits/stackButton.dart';
import 'package:image_picker/image_picker.dart';

class EditSupplierProfile extends StatefulWidget {
  @override
  _EditSupplierProfileState createState() => _EditSupplierProfileState();
}

class _EditSupplierProfileState extends State<EditSupplierProfile> {

  String imagePath;
  var name = TextEditingController.fromValue(TextEditingValue(text: AppData.supplier.person.name));
  var _email = TextEditingController.fromValue(TextEditingValue(text: AppData.supplier.person?.email??''));
  final key = GlobalKey<ScaffoldState>();
  final form = GlobalKey<FormState>();
  bool autoValidate=false;
  Location pickerData;
  PickedFile image;

  var _service1 = AppData.supplier.services.contains('Construction Dumpster');
  var _service2 = AppData.supplier.services.contains('Scaffolding');
  var _service3 = AppData.supplier.services.contains('Building Material');
  var _service4 = AppData.supplier.services.contains('Finishing Material');
  var _service5 = AppData.supplier.services.contains('Delivery Vehicle');




  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) =>  Scaffold(
        key: key,
        appBar: HaweyatiAppBar(actions: [],),
        body: SingleChildScrollView(

          padding: EdgeInsets.all(20),
          child: Form(
            autovalidate: autoValidate,
            key: form,
            child: Column(children: <Widget>[
              HaweyatiTextField(
                controller: name,
                validator: (value) => emptyValidator(value, lang.name),
                label: lang.name,
              ),
              SizedBox(height: 15,),
              HaweyatiTextField(
                label: lang.email,
                icon: Icons.mail,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                // validator: (value) => value.isEmpty ? "Please Enter Email" : null,
              ),
              LocationPickerWidget(
                location: AppData.supplier.location,
                onChanged: (Location loc){
                  pickerData = loc;
                  // print(pickerData.address);
                  // print(pickerData.longitude);
                },
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Text(lang.selectServices, style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
              ),

              ListTile(
                dense: true,
                leading: Text(lang.constructionDumpsters),
                trailing: Switch(
                    value: _service1,
                    onChanged: (val) => setState(() => _service1 = val)
                ),
              ),

              ListTile(
                dense: true,
                leading: Text(lang.scaffoldings),
                trailing: Switch(
                    value: _service2,
                    onChanged: (val) => setState(() => _service2 = val)
                ),
              ),

              ListTile(
                dense: true,
                leading: Text(lang.buildingMaterials),
                trailing: Switch(
                    value: _service3,
                    onChanged: (val) => setState(() => _service3 = val)
                ),
              ),

              ListTile(
                dense: true,
                leading: Text(lang.finishingMaterials),
                trailing: Switch(
                    value: _service4,
                    onChanged: (val) => setState(() => _service4 = val)
                ),
              ),

              ListTile(
                dense: true,
                leading: Text(lang.deliveryVehicles),
                trailing: Switch(
                    value: _service5,
                    onChanged: (val) => setState(() => _service5 = val)
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ImagePickerWidget(
                  previousImage: AppData.supplier?.person?.image?.name,
                    onImagePicked: (file) {
                  image = file;
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: StackButton(buttonName: lang.submit,onTap: () async{
                  List<String> services = [];
                  services.clear();
                  if(_service1){
                    services.add('Construction Dumpster');
                  }
                  if(_service2){
                    services.add('Scaffolding');
                  }
                  if(_service3){
                    services.add('Building Material');
                  }
                  if(_service4){
                    services.add('Finishing Material');
                  }
                  if(form.currentState.validate()){
                    print("my id");
                    print(AppData.supplier.id);
                    FocusScope.of(context).requestFocus(FocusNode());
                    FocusScope.of(context).requestFocus(FocusNode());
                    openLoadingDialog(context, lang.updatingProfile);
                    FormData profile = FormData.fromMap({
                      '_id' : AppData.supplier.id,
                      'personId' : AppData.supplier.person.id,
                      'image' :  image!=null ? await MultipartFile.fromFile(image.path) : null,
                      'name' : name.text,
                      'email' : _email.text,
                      'latitude' : pickerData.latitude,
                      'services' : services,
                      'longitude' : pickerData.longitude,
                      'address' : pickerData.address
                    });

                    var res = await HaweyatiService.patch('suppliers', profile);
                    // print(res.data);

                    try{
                      await AppData.signIn(SupplierModel.fromJson(res.data));
                      Navigator.pop(context);
                      Navigator.pop(context);
                      print(res.data);
                      // print("received from up");
                    } catch (e){
                      // throw e;
                      // print("exception arahi hai ${e.toString()}");
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
            ],),
          ),),),
    );
  }
}
