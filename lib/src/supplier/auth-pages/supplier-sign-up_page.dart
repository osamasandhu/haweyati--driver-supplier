import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/location_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/persons-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/supplier-Services.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-utils.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import 'package:image_picker/image_picker.dart';
import 'waiting-approval_page.dart';

class SupplierSignUpPage extends StatefulWidget {
  final String phoneNumber;
  final Profile person;
  SupplierSignUpPage({this.phoneNumber,this.person});
  @override
  _SupplierSignUpPageState createState() => _SupplierSignUpPageState();
}

class _SupplierSignUpPageState extends State<SupplierSignUpPage> {

  Location supplierLocation;
  PickedFile image;
  var _isSub = false;
  var _service1 = false;
  var _service2 = false;
  var _service3 = false;
  var _service4 = false;

  final _name = TextEditingController();
  final _email = TextEditingController();
  // final _phone = TextEditingController();
  final _address = TextEditingController();
  final _password = TextEditingController();
  Future<List<SupplierModel>> suppliers;
  String shopParentId;

  final _key = GlobalKey<SimpleFormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();


   @override
 void initState() {
   super.initState();
   suppliers = SupplierServices().getSupplier();
   // suppliers.then((value) => print(value));

 }

  @override
  Widget build(BuildContext context) {
    return ScrollableView(
      key: scaffoldKey,
      fab: FloatingActionButton(
        child: Icon(Icons.done,color: Colors.white,),
        onPressed: (){
          _key.currentState.submit();
        },
      ),
      appBar: HaweyatiAppBar(hideHome: true,),
      child: SimpleForm(
        key: _key,
        onSubmit: () async {
          if(supplierLocation==null){
           scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Please select your location"),
              behavior: SnackBarBehavior.floating,
             backgroundColor: Colors.red,
            ));
            return;
          }

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

          if(services.isEmpty){
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("You must select at least one service"),
            ));
            return;
          }


          if (_isSub && shopParentId == null) {
             scaffoldKey.currentState.showSnackBar(SnackBar(
               content: Text("Please Select Branch"),
             ));
             return;
          }

          Map<String,dynamic> supplierMap = {
            'person' : widget?.person?.id,
            'name' : _name.text,
            'contact' : widget.phoneNumber,
            'address' :  _address.text,
            'email' :  DateTime.now().toIso8601String(),
            'password' :  _password.text,
            'parent' : shopParentId,
            // 'city' : supplierLocation.city,
            'services' : services,
            'latitude': supplierLocation.latitude,
            'longitude': supplierLocation.longitude,
          };

          FormData supplier = FormData.fromMap(supplierMap);

          if(image!=null){
            supplier.files.add(MapEntry(
              'image', await MultipartFile.fromFile(image.path)
             ));
          }

          openLoadingDialog(context,'Signing up');

          var res;

          try {
            res = await HaweyatiService.post('suppliers', supplier);
            // print(res);
          } catch (e) {
            Navigator.pop(context);
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text(e.toString()),
            ));
          }
          print(res);

          var token;
          try{
            var user = await HaweyatiService.post('auth/sign-in', {"username" : widget?.person?.username ?? widget.phoneNumber , "password" : widget?.person?.password ?? _password.text});
            token = user.data['access_token'];}
          catch(e){
            Navigator.pop(context);
            scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Your account already exists "),
            ));
            return;
          }

          await Utils.setToken(token);

          PersonsService().getSignedInPerson().then((value) async {
           SupplierModel supplier = await SupplierServices().supplierProfile(value.id);

           await AppData.signIn(supplier);
           CustomNavigator.pushReplacement(context, WaitingApproval());
          });

        },
        child:  Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text('Register as Supplier', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text('Enter Required Information'),
          ),
         widget.person == null ? HaweyatiTextField(
            label: "Name",
            controller: _name,
            icon: Icons.person,
            validator: (value) => value.isEmpty ? "Please Enter Name" : null
          ) : SizedBox(),
          SizedBox(height: 15),
          // HaweyatiTextField(
          //   label: "Email",
          //   icon: Icons.mail,
          //   controller: _email,
          //   keyboardType: TextInputType.emailAddress,
          //   validator: (value) => value.isEmpty ? "Please Enter Email" : null,
          // ),
          // SizedBox(height: 15),
        AbsorbPointer(
          absorbing: true,
          child: Opacity(
            opacity: 0.5,
            child: HaweyatiTextField(
                label: "Phone",
                icon: Icons.call,
                controller: TextEditingController(text: widget?.person?.username ?? widget.phoneNumber),
                keyboardType: TextInputType.phone,
                // validator: (value) => value.isEmpty ? "Please Enter Phone" : null,
              ),
          ),
        ),
          SizedBox(height: 15),
          HaweyatiTextField(
            label: "Address",
            controller: _address,
            keyboardType: TextInputType.text,
            validator: (value) => value.isEmpty ? "Please Enter Address" : null,
          ),
          SizedBox(height: 15),
          widget.person == null ? HaweyatiPasswordField(
            context: context,
            label: "Password",
            controller: _password,
            validator: (value) => passwordValidator(value),
          ) : SizedBox(),
          SizedBox(height: 15),

          LocationPickerWidget(
            onChanged: (location){
                supplierLocation = location;
            },
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 20),
            child: Text('Services', style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold
            )),
          ),

          ListTile(
            dense: true,
            leading: Text('Construction Dumpsters'),
            trailing: Switch(
              value: _service1,
              onChanged: (val) => setState(() => _service1 = val)
            ),
          ),

          ListTile(
            dense: true,
            leading: Text('Scaffolding'),
            trailing: Switch(
              value: _service2,
              onChanged: (val) => setState(() => _service2 = val)
            ),
          ),

          ListTile(
            dense: true,
            leading: Text('Building Materials'),
            trailing: Switch(
              value: _service3,
              onChanged: (val) => setState(() => _service3 = val)
            ),
          ),

          ListTile(
            dense: true,
            leading: Text('Finishing Materials'),
            trailing: Switch(
              value: _service4,
              onChanged: (val) => setState(() => _service4 = val)
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImagePickerWidget(onImagePicked: (file) {
              image = file;
            }),
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
                          subtitle: Text(_supplier.location?.address ??
                              'Address not specified'),
                          trailing: Radio(
                              value: _supplier.sId,
                              groupValue: shopParentId,
                              onChanged: (val) {
                                setState(() {
                                  shopParentId = val;
                                });
                              }),
                        );
                      });
                }),
          ) : SizedBox()
        ]),
      ),
    );
  }
}
