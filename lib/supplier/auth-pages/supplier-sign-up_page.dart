import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:haweyati_supplier_driver_app/model/supplier/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/persons-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/supplier-Services.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-data.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-utils.dart';
import 'package:haweyati_supplier_driver_app/widgits/locations-map_page.dart';
import 'package:image_picker/image_picker.dart';
import 'waiting-approval_page.dart';

class SupplierSignUpPage extends StatefulWidget {
  final String phoneNumber;
  final PersonModel person;
  SupplierSignUpPage({this.phoneNumber,this.person});
  @override
  _SupplierSignUpPageState createState() => _SupplierSignUpPageState();
}

class _SupplierSignUpPageState extends State<SupplierSignUpPage> {

  LocationPickerData supplierLocation;
  PickedFile image;
  var _isSub = false;
  var _service1 = false;
  var _service2 = false;
  var _service3 = false;
  var _service4 = false;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
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
   suppliers.then((value) => print(value));

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done,color: Colors.white,),
        onPressed: (){
          _key.currentState.submit();
        },
      ),
      appBar: HaweyatiAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(child: SimpleForm(
          key: _key,
          onSubmit: () async {
            print(supplierLocation);
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
            if (_isSub && shopParentId == null) {
               scaffoldKey.currentState.showSnackBar(SnackBar(
                 content: Text("Please Select Branch"),
               ));
            }

            Map<String,dynamic> supplierMap = {
              'person' : widget?.person?.id,
              'name' : _name.text,
              'contact' : _phone.text,
              'address' :  _address.text,
              'email' :  DateTime.now().toIso8601String(),
              'password' :  _password.text,
              'parent' : shopParentId,
              'city' : supplierLocation.city,
              'services' : services,
              'latitude': supplierLocation.position.latitude,
              'longitude': supplierLocation.position.longitude,
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
              var user = await HaweyatiService.post('auth/sign-in', {"username" : widget?.person?.username ?? _phone.text , "password" : widget?.person?.password ?? _password.text});
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
          widget.person == null ?  HaweyatiTextField(
              label: "Phone",
              icon: Icons.call,
              controller: _phone,
              keyboardType: TextInputType.phone,
              validator: (value) => value.isEmpty ? "Please Enter Phone" : null,
            ) : SizedBox(),
            SizedBox(height: 15),
            HaweyatiTextField(
              label: "Address",
              controller: _address,
              validator: (value) => value.isEmpty ? "Please Enter Address" : null,
            ),
            SizedBox(height: 15),
            widget.person == null ?HaweyatiPasswordField(
              context: context,
              label: "Password",
              controller: _password,
              validator: (value) => value.isEmpty ? "Please Enter Password" : null,
            ) : SizedBox(),

            LocationPickerWidget(
              onChanged: (location){
                if(location!=null){
                  supplierLocation = location;
                }
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
            ) : SizedBox()
          ]),
        )),
      ),
    );
  }
}

//
//  File _image;
//  bool loading = false;
//  AuthArguments _arguments;
////  bool autoValidate = false;
////  var _formKey = GlobalKey<FormState>();
//  String shopParentId;
//  String groupValue;
//  String token;
//
//  final _name = new TextEditingController();
//  final _email = new TextEditingController();
//  final _phone = new TextEditingController();
//  final _address = new TextEditingController();
//  final _password = new TextEditingController();
//  SharedPreferences prefs;
//  UserLocation userLocation;
//  DateTime selectedDate = DateTime.now();
//
//  @override
//
//  void initState() {
//    super.initState();
//    firebaseCloudMessaging_Listeners();
//
//    initMap();
//    suppliers = SupplierServices().getSupplier();
//    suppliers.then((value) => print(value));
//
//  }
//
//  void firebaseCloudMessaging_Listeners() {
//    if (Platform.isIOS) iOS_Permission();
//
//    _firebaseMessaging.getToken().then((abc) {
//      print('THis is Your Mobile Token $abc');
//      setState(() {
//        token = abc;
//      });
//    });
//
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('on message $message');
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('on resume $message');
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('on launch $message');
//      },
//    );
//  }
//
//  void iOS_Permission() {
//    _firebaseMessaging.requestNotificationPermissions(
//        IosNotificationSettings(sound: true, badge: true, alert: true));
//    _firebaseMessaging.onIosSettingsRegistered
//        .listen((IosNotificationSettings settings) {
//      print("Settings registered: $settings");
//    });
//  }
//
//  initMap() async {
//    prefs = await SharedPreferences.getInstance();
//    setState(() {
//      userLocation = UserLocation(
//        city: prefs.getString('city'),
//        address: prefs.getString('address'),
//        cords:
//            LatLng(prefs.getDouble('latitude'), prefs.getDouble('longitude')),
//      );
//    });
//  }
//
//  Color selectedColor;
//  Future<List<SupplierModel>> suppliers;
//
//  @override
//  Widget build(BuildContext context) {
//    return ScrollablePage(
//      title: 'Sign up',
//      showBackgroundImage: false,
//      subtitle: 'Enter required information',
//
//      child: SimpleForm(
//        builder: (context, submitted) {
//          return SliverToBoxAdapter(child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20),
//            child: Column(children: <Widget>[
//              TextFormField(
//                decoration: InputDecoration(
//                  border: OutlineInputBorder(),
//                )
//              ),
//
//              Padding(
//                padding: const EdgeInsets.only(top: 15),
//                child: DarkContainer(child: Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: Container(child: Column(children: <Widget>[
//                    Row(children: <Widget>[
//                      FlatButton(
//                        shape: StadiumBorder(),
//                        textColor: Colors.white,
//                        color: Theme.of(context).accentColor,
//                        child: Text('Camera'),
//                        onPressed: () async {
//                          final image = await ImagePicker().getImage(source: ImageSource.camera);
////                            if (image != null) setState(() => this._image = image);
//                        }
//                      ),
//                      FlatButton(
//                        shape: StadiumBorder(),
//                        textColor: Colors.white,
//                        color: Theme.of(context).accentColor,
//                        child: Text('Gallery'),
//                        onPressed: () async {
//                          final image = await ImagePicker().getImage(source: ImageSource.gallery);
////                            if (image != null) setState(() => this._image = image);
//                        }
//                      ),
//                    ], mainAxisAlignment: MainAxisAlignment.spaceBetween),
//
//                    Container(
//                      height: 200,
//                      margin: const EdgeInsets.only(top: 5),
//                      decoration: BoxDecoration(
//                        color: Colors.grey.shade300,
//                        borderRadius: BorderRadius.circular(10)
//                      ),
//                      child: Center(
//                          child: _image == null ? Text('No Image is Selected', style: TextStyle(
//                            color: Colors.grey.shade600,
//                            fontStyle: FontStyle.italic
//                          )): Container(
//                            constraints: BoxConstraints.expand(),
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(10),
//                              image: DecorationImage(
//                                fit: BoxFit.cover,
//                                image: FileImage(File(_image.path))
//                              )
//                            ),
//                            child: Align(
//                              alignment: Alignment(.95, -.95),
//                              child: SizedBox(
//                                width: 35,
//                                height: 35,
//                                child: FlatButton(
//                                  color: Colors.red,
//                                  padding: EdgeInsets.zero,
//                                  child: Icon(Icons.delete, color: Colors.white),
//                                  shape: RoundedRectangleBorder(
//                                    borderRadius: BorderRadius.circular(30)
//                                  ),
//                                  onPressed: () => setState(() => _image = null)
//                                ),
//                              ),
//                            ),
//                          )
//                        )
//                      )
//                    ])),
//                  )),
//                ),
//                
//                Row(children: <Widget>[
//                  Checkbox(
//                    value: check,
//                    onChanged: (val) {},
//                  ),
//                  Text('It is a Sub Branch'),
//                ]),
//

////      child: SliverToBoxAdapter(
////        child: Form(
////          autovalidate: autoValidate,
////          key: _formKey,
////          child: Column(
////            children: <Widget>[
//////              Text("Signup",
//////                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
//////              SizedBox(height: 15),
//////              Text("Please Enter Credentials",
//////                  style: TextStyle(color: Colors.black54)),
//////              SizedBox(height: 15),
////              EmptyContainer(
////                child: Column(
////                  mainAxisAlignment: MainAxisAlignment.start,
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  children: <Widget>[
////                    Row(
////                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      children: <Widget>[
////                        Text(
////                          "City",
//////                          style: boldText,
////                        ),
////                        FlatButton.icon(
////                            onPressed: () async {
////                              UserLocation location = await  Navigator.of(context).push(MaterialPageRoute(
////                                  builder: (context) => MyLocationMapPage(
////                                    editMode: true,
////                                  )));
////                              setState(() {
////                                userLocaton = location;
////                              });
////                            },
////                            icon: Icon(
////                              Icons.edit,
////                              color: Theme.of(context).accentColor,
////                            ),
////                            label: Text(
////                              "Edit",
////                              style:
////                              TextStyle(color: Theme.of(context).accentColor),
////                            ))
////                      ],
////                    ),
////                    SizedBox(
////                      height: 15,
////                    ),
////                    Row(
////                      children: <Widget>[
////                        Icon(
////                          Icons.location_on,
////                          color: Theme.of(context).accentColor,
////                        ),
////                        Expanded(
////                          child: Padding(
////                            padding: const EdgeInsets.only(left: 10),
////                            child: Text(prefs?.getString('city') ?? ''),
////                          ),
////                        )
////                      ],
////                    ),
////                  ],
////                ),
////              ),
////              Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                  children: <Widget>[
////                    FlatButton(
////                      onPressed: getCamera,
////                      child: Text("Camera"),
////                      shape: StadiumBorder(),
////                      textColor: Colors.white,
////                      color: Theme.of(context).accentColor,
////                    ),
////                    FlatButton(
////                      onPressed: getGallery,
////                      child: Text("Gallery"),
////                      shape: StadiumBorder(),
////                      textColor: Colors.white,
////                      color: Theme.of(context).accentColor,
////                    )
////                  ]),
////              SizedBox(height: 10),
////              Container(
////                height: 200.0,
////                width: 150,
////                child: _image == null
////                    ? Container(
////                        decoration: BoxDecoration(
////                            color: Colors.white,
////                            borderRadius: BorderRadius.circular(10),
////                            border: Border.all(
////                                width: 2,
////                                color: Theme.of(context).accentColor)),
////                        child: Center(child: Text('No image selected.')))
////                    : ClipRRect(
////                        borderRadius: BorderRadius.circular(30),
////                        child: Text("data")
//////                    Image.file(
//////                      _image, fit: BoxFit.cover,
//////                    )
////                        ),
////              ),
////              SizedBox(height: 15),
////              Row(
////                children: <Widget>[
////                  Expanded(
////                      child: Divider(
////                    color: Colors.black,
////                    height: 1,
////                  )),
////                  SizedBox(
////                    width: 5,
////                  ),
////                  Text(
////                    "Vehicle Detail",
////                  ),
////                  SizedBox(
////                    width: 5,
////                  ),
////                  Expanded(
////                      child: Divider(
////                    color: Colors.black,
////                    height: 1,
////                  )),
////                ],
////              ),
////              SizedBox(height: 15),
////            ],
////          ),
////        ),
////      ),
//
////      floatingActionButtonLocation:
////      FloatingActionButtonLocation.endDocked,
////      floatingActionButton:
////      FloatingActionButton(
////        elevation: 0,
////        child: Icon(Icons.arrow_forward),
////        onPressed: () async {
////          Profile profileModel = Profile
////            (
////                email: email.text,
////                contact: DateTime.now().toIso8601String(),
////                password: password.text,
////                name: name.text,
////                type: 'Driver',
////            );
////
////          FormData profileData = FormData.fromMap(profileModel.toJson());
////
////          _image != null
////              ? profileData.files.add(MapEntry(
////                  'image',
////                  await MultipartFile.fromFile(_image.path,
////                      filename: DateTime.now().toIso8601String())))
////              : print('No image');
////
////
////          Response profileResponse = await HaweyatiSupplierDriverService.post('persons', profileData);
////          String profileId = profileResponse.data['_id'];
////
////          DriverModel driver = DriverModel(
////            profileId: profileId,
////            status: 'Pending',
////            license: licenseNum.text,
////            city: prefs.getString('city'),
////            vehicle: Vehicle(
////              name: vehicleName.text,
////              model: model.text,
////              identificationNo: identification.text
////            ),
////          );
////
////          Dio().post('$apiUrl/drivers', data: driver.toJson());
////
////        },
////        foregroundColor: Colors.white,
////      ),
////      bottomNavigationBar: Container(
////        height: 50,
////        child: Align(
////          alignment: Alignment(0, -1),
////          child: GestureDetector(
////            onTap: () {
////              Navigator.of(context)
////                  .pushReplacementNamed('/sign-in', arguments: _arguments);
////            },
////            child: Text("LOGIN WITH EMAIL",
////                style: TextStyle(color: Theme.of(context).accentColor)),
////          ),
////        ),
////      ),
//    );
//  }
////  @override
////  Widget build(BuildContext context) {
////    Future getCamera() async {
////      var image = await ImagePicker.pickImage(source: ImageSource.camera);
////      setState(() {
////        _image = image;
////      });
////    }
////
////    Future getGallery() async {
////      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
////      setState(() {
////        _image = image;
////      });
////    }
////
////    this._arguments =
////        ModalRoute.of(context).settings.arguments as AuthArguments;
////
////    return Scaffold(
////      key: scaffoldKey,
////      appBar: HaweyatiAppBar(
////        context: context,
////      ),
////      body: Form(
////        autovalidate: autoValidate,
////        key: _formKey,
////        child: SingleChildScrollView(
////          padding: EdgeInsets.fromLTRB(20, 50, 20, 150),
////          child: Column(
////            children: <Widget>[
////              Text("Signup",
////                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
////              SizedBox(height: 15),
////              Text("Please Enter Credentials",
////                  style: TextStyle(color: Colors.black54)),
////              SizedBox(height: 15),
////              HaweyatiTextField(
////                label: "Name",
////                controller: name,
////                icon: Icons.person,
////                validator: (value) {
////                  return value.isEmpty ? "Please Enter Name" : null;
////                },
////                context: context,
////              ),
////              SizedBox(height: 15),
////              HaweyatiTextField(
////                keyboardType: TextInputType.emailAddress,
////                label: "Email",
////                controller: email,
////                icon: Icons.mail,
////                validator: (value) {
////                  return value.isEmpty ? "Please Enter Email" : null;
////                },
////                context: context,
////              ),
////              SizedBox(height: 15),
////              HaweyatiTextField(
////                keyboardType: TextInputType.emailAddress,
////                label: "Phone",
////                controller: phone,
////                icon: Icons.call,
////                validator: (value) {
////                  return value.isEmpty ? "Please Enter Phone" : null;
////                },
////                context: context,
////              ),
////              SizedBox(height: 15),
////              HaweyatiPasswordField(
////                label: "Password",
////                controller: password,
////                validator: (value) {
////                  return value.isEmpty ? "Please Enter Password" : null;
////                },
////                context: context,
////              ),
//////              SizedBox(height: 15),
//////              HaweyatiTextField(
//////                label: "City",
//////                controller: city,
//////                icon: Icons.location_city,
//////                validator: (value) {
//////                  return value.isEmpty ? "Please Enter City" : null;
//////                },
//////                context: context,
//////              ),
////              SizedBox(height: 15),
////              HaweyatiTextField(
////                label: "Address",
////                controller: address,
////                icon: Icons.add_location,
////                validator: (value) {
////                  return value.isEmpty ? "Please Enter Address" : null;
////                },
////                context: context,
////              ),
////
//////              SizedBox(height: 15),
//////              HaweyatiTextField(
//////                label: "Location",
//////                controller: location,
//////                icon: Icons.location_on,
//////                validator: (value) {
//////                  return value.isEmpty ? "Please Enter Location" : null;
//////                },
//////                context: context,
//////              ),
////              SizedBox(
////                height: 12,
////              ),
////              Align(
////                  alignment: Alignment.centerLeft,
////                  child: Text(
////                    "Services",
////                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
////                  )),
////              CheckboxListTile(
////                dense: true,
////                value: check,
////                onChanged: (val) {
////                  setState(() {
////                    check = val;
////                  });
////                },
////                title: Text("Construction Dumpster"),
////              ),
////              SizedBox(
////                height: 12,
////              ),
////              CheckboxListTile(
////                dense: true,
////                value: check1,
////                onChanged: (val1) {
////                  setState(() {
////                    check1 = val1;
////                  });
////                },
////                title: Text("Scaffolding"),
////              ),
////              SizedBox(
////                height: 12,
////              ),
////              CheckboxListTile(
////                dense: true,
////                value: check2,
////                onChanged: (val2) {
////                  setState(() {
////                    check2 = val2;
////                    print(val2);
////                  });
////                },
////                title: Text("Building Material"),
////              ),
////              SizedBox(
////                height: 12,
////              ),
////              CheckboxListTile(
////                dense: true,
////                value: check3,
////                onChanged: (val3) {
////                  setState(() {
////                    check3 = val3;
////                  });
////                },
////                title: Text("Finishing Material"),
////              ),
////              SizedBox(
////                height: 12,
////              ),
////              EmptyContainer(
////                child: Column(
////                  mainAxisAlignment: MainAxisAlignment.start,
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  children: <Widget>[
////                    Row(
////                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      children: <Widget>[
////                        Text(
////                          "City",
//////                          style: boldText,
////                        ),
////                        FlatButton.icon(
////                            onPressed: () async {
////                              UserLocation location = await Navigator.of(
////                                      context)
////                                  .push(MaterialPageRoute(
////                                      builder: (context) => MyLocationMapPage(
////                                            editMode: true,
////                                          )));
////                              setState(() {
////                                userLocation = location;
////                              });
////                            },
////                            icon: Icon(
////                              Icons.edit,
////                              color: Theme.of(context).accentColor,
////                            ),
////                            label: Text(
////                              "Edit",
////                              style: TextStyle(
////                                  color: Theme.of(context).accentColor),
////                            ))
////                      ],
////                    ),
////                    SizedBox(
////                      height: 15,
////                    ),
////                    Row(
////                      children: <Widget>[
////                        Icon(
////                          Icons.location_on,
////                          color: Theme.of(context).accentColor,
////                        ),
////                        Expanded(
////                          child: Padding(
////                            padding: const EdgeInsets.only(left: 10),
////                            child: Text(prefs?.getString('city') ?? ''),
////                          ),
////                        )
////                      ],
////                    ),
////                  ],
////                ),
////              ),
////              Row(
////                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                  children: <Widget>[
////                    FlatButton(
////                      onPressed: getCamera,
////                      child: Text("Camera"),
////                      shape: StadiumBorder(),
////                      textColor: Colors.white,
////                      color: Theme.of(context).accentColor,
////                    ),
////                    FlatButton(
////                      onPressed: getGallery,
////                      child: Text("Gallery"),
////                      shape: StadiumBorder(),
////                      textColor: Colors.white,
////                      color: Theme.of(context).accentColor,
////                    )
////                  ]),
////              SizedBox(height: 10),
////              Container(
////                height: 200.0,
////                width: 150,
////                child: _image == null
////                    ? Container(
////                        decoration: BoxDecoration(
////                            color: Colors.white,
////                            borderRadius: BorderRadius.circular(10),
////                            border: Border.all(
////                                width: 2,
////                                color: Theme.of(context).accentColor)),
////                        child: Center(child: Text('No image selected.')))
////                    : ClipRRect(
////                        borderRadius: BorderRadius.circular(30),
////                        child: Image.file(
////                          _image,
////                          fit: BoxFit.cover,
////                        )),
////              ),
////              SizedBox(height: 15),
////              CheckboxListTile(
////                  title: Text("Is SubBranch"),
////                  dense: true,
////                  value: check5,
////                  onChanged: (val5) {
////                    setState(() {
////                      check5 = val5;
////                    });
////                  }),
////              check5
////                  ?
////            ],
////          ),
////        ),
////      ),
////      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
////      floatingActionButton: FloatingActionButton(
////        elevation: 0,
////        child: Icon(Icons.arrow_forward),
////        onPressed: () async {
////
////          print('onpreess $token');
////          selectedServices.clear();
////          if (check) selectedServices.add('Construction Dumpster');
////          if (check1) selectedServices.add('Scaffolding');
////          if (check2) selectedServices.add('Building Material');
////          if (check3) selectedServices.add('Finishing Material');
////
////          if (check5 && shopParentId == null) {
////            scaffoldKey.currentState.showSnackBar(SnackBar(
////              content: Text("Please Select Branch"),
////            ));
////            return print("You Are Submitting without Branch");
////          }
////
////          SupplierModel supplier = SupplierModel(
////
////            name: name.text,
////            scope: 'supplier',
////            city: userLocation.city,
////            contact: phone.text,
////            password: password.text,
////            email: email.text,
////              address: userLocation.address,
////              latitude: userLocation.cords.latitude,
////              longitude: userLocation.cords.longitude,
////            services: selectedServices,
////            shopParentId: shopParentId,
////          );
////
////          FormData supplierData = FormData.fromMap(supplier.toJson());
////
////          _image != null
////              ? supplierData.files.add(MapEntry(
////                  'image',
////                  await MultipartFile.fromFile(_image.path,
////                      filename: DateTime.now().toIso8601String())))
////              : print('No image');
//////
////          var registered = await HaweyatiSupplierDriverService.post(
////              'suppliers', supplierData);
//////
//////          print(supplier.toJson());
////
//////         print(registered.data['_id']);
////          print(registered.data);
//////          print(registered);
////          FcmModel fcm = FcmModel(token: token, person: registered.data['_id']);
////
////          print(fcm.toJson());
////
//////          await HaweyatiSupplierDriverService.post('fcm', fcm.toJson());
////          //
//////          if (_formKey.currentState.validate()) {
//////            showDialog(
//////                context: context,
//////                builder: (context) => AlertDialog(
//////                      content: Row(children: <Widget>[
//////                        CircularProgressIndicator(strokeWidth: 2),
//////                        SizedBox(
//////                          width: 4,
//////                        ),
//////                        Text("Submitting your form")
//////                      ]),
//////                    ));
//////
//////            Future.delayed(Duration(seconds: 2), () {
//////              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//////            });
//////          } else {
//////            setState(() => autoValidate = true);
//////          }
////        },
////        foregroundColor: Colors.white,
////      ),
////      bottomNavigationBar: Container(
////        height: 50,
////        child: Align(
////          alignment: Alignment(0, -1),
////          child: GestureDetector(
////            onTap: () {
////              Navigator.of(context)
////                  .pushReplacementNamed('/sign-in', arguments: _arguments);
////            },
////            child: Text("LOGIN WITH EMAIL",
////                style: TextStyle(color: Theme.of(context).accentColor)),
////          ),
////        ),
////      ),
////    );
////  }
//}
//
//class User {
//  String firstName;
//  String lastName;
//
//  static List<User> getUsers() {
//    return [];
//  }
//}
////"http://192.168.1.104:4000/uploads/${_supplier.images[index].name}"
