import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/driver_model.dart';
import 'package:haweyati_supplier_driver_app/src/models/users/supplier_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/services/persons-service.dart';
import 'package:haweyati_supplier_driver_app/src/pre-sign-up-phone-verification.dart';
import 'package:haweyati_supplier_driver_app/src/services/drivers_service.dart';
import 'package:haweyati_supplier_driver_app/src/services/supplier-Services.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/auth-pages/waiting-approval_page.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/supplier-homepage.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-utils.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import '../reset-password_page.dart';

class SignInPage extends StatelessWidget {
  final bool _isSupplier;
  SignInPage([this._isSupplier = false]);

  final _username = new TextEditingController();
  final _password = new TextEditingController();
  var _key = GlobalKey<SimpleFormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: HaweyatiAppBar(actions: [],),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done,color: Colors.white,),
        onPressed: ()=> _key.currentState.submit(),
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SimpleForm(
          key: _key,
          onSubmit: () async {
            openLoadingDialog(context, "Signing in");
            Map<String,dynamic> signIn = {
              'username' : _username.text,
              'password' : _password.text
            };
            var token;
            try {
              var res = await HaweyatiService.post(
                  'auth/sign-in', signIn);
              print(res.data['access_token']);
              token = res.data['access_token'];
            } catch (e) {
              Navigator.pop(context);
              showSimpleSnackbar(scaffoldKey, "Incorrect username or password",true);
            }

            await Utils.setToken(token);

            Profile person = await PersonsService().getSignedInPerson();

            if(_isSupplier){
              if(!person.scope.contains('supplier')){
                Navigator.pop(context);
                showSimpleSnackbar(scaffoldKey, "You are not registered as a Supplier. Please sign up as a Supplier.",true);
                return;
              }
              SupplierModel supplier = await SupplierServices().supplierProfile(person.id);
              await AppData.signIn(supplier);
              if(supplier.status=='Active'){
                CustomNavigator.pushReplacement(context, SupplierHomePage());
              }else{
                CustomNavigator.pushReplacement(context, WaitingApproval());
              }

            } else {
              if(!person.scope.contains('driver')){
                Navigator.pop(context);
                showSimpleSnackbar(scaffoldKey, "You are not registered as a Driver. Please sign up as a Supplier.",true);
                return;
              }
              Driver driver;
              try{
                 driver = await DriverService().getDriverByPerson(person.id);
              } catch (e){
                Navigator.pop(context);
                showSimpleSnackbar(scaffoldKey, "We are experiencing some difficulties. Please try again later.",true);
                return;
              }
              await AppData.signIn(driver);
              if(driver.status=='Active'){
                CustomNavigator.pushReplacement(context, SupplierHomePage());
              }else{
                CustomNavigator.pushReplacement(context, WaitingApproval());
              }
            }

          },
          child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text('Sign in', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Text('Please Enter Credentials'),
              ),
              HaweyatiTextField(
                controller: _username,
                label: "Phone Number",
                keyboardType: TextInputType.phone,
                //todo: uncomment validator
                // validator: (value) => phoneValidator(value),
              ),
              SizedBox(height: 20),
              HaweyatiPasswordField(
                context: context,
                label: "Password",
                controller: _password,
                validator: (value) => passwordValidator(value),
              ),
              Align(
                alignment: Alignment(1, 1),
                child: GestureDetector(
                  onTap: () async  {
                  String verifiedNumber = await  CustomNavigator.navigateTo(context, PreSignUpPhoneVerifier(forgotPassword: true,));

                  if(verifiedNumber!=null){
                    CustomNavigator.navigateTo(context, ResetPasswordPage(phoneNumber: verifiedNumber,));
                  }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('Forgot Password?', style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).accentColor
                    )),
                  ),
                )
              ),

              SizedBox(height: MediaQuery.of(context).size.height - 420),
              Stack(children: <Widget>[
                Align(
                  alignment: Alignment(0, 0),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed('/pre-sign-up');
                      },
                      child: Text('REGISTER NOW', style: TextStyle(
                        color: Theme.of(context).accentColor
                      )),
                    ),
                  ),
                ),

              ])
            ]))),


        ),
      );
  }
}
