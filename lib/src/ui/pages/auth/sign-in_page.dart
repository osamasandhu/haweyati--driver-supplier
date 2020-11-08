import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/driver/driver-home_page.dart';
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
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/contact-input-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/header-view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/const.dart';
import 'package:haweyati_supplier_driver_app/utils/haweyati-utils.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:haweyati_supplier_driver_app/widgits/localization-selector.dart';
import '../reset-password_page.dart';

class HaweyatiSignIn extends StatefulWidget {
  final bool _isSupplier;
  HaweyatiSignIn([this._isSupplier = false]);

  @override
  _HaweyatiSignInState createState() => _HaweyatiSignInState();
}

class _HaweyatiSignInState extends State<HaweyatiSignIn> {
  final _username = new TextEditingController();

  final _password = new TextEditingController();

  bool isPhoneValid = false;

  var _key = GlobalKey<SimpleFormState>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => Scaffold(
        key: scaffoldKey,
        appBar: HaweyatiAppBar(
          hideHome: true,
          actions: [Center(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: LocalizationSelector(),
          ))],
        ),        floatingActionButton: FloatingActionButton(
        backgroundColor: !isPhoneValid ? Colors.grey : null,
          elevation: 0,
         child: Transform.rotate(
            angle: AppLocalizations.of(context).localeName == 'ar' ? 3.14: 0,
          child: Image.asset(NextFeatureIcon, width: 30)
           ),

          onPressed: () {
              if(!isPhoneValid){
                showSimpleSnackbar(scaffoldKey, lang.inputValidPhone,true);
                return;
              }
               _key.currentState.submit();
              }
          ,
        ),
        body: DottedBackgroundView(
          child: SingleChildScrollView(child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SimpleForm(
              key: _key,
              onSubmit: () async {
                openLoadingDialog(context, lang.signingIn);
                Map<String,dynamic> signIn = {
                  'username' :  _username.text,
                  'password' : _password.text
                };

                print(signIn);

                var token;
                try {
                  var res = await HaweyatiService.post(
                      'auth/sign-in', signIn);
                  // print(res.data['access_token']);
                  token = res.data['access_token'];
                  // print(token);
                  // print("xgrdchtfvjgybkhnjn");

                } catch (e) {
                  Navigator.pop(context);
                  showSimpleSnackbar(scaffoldKey, lang.incorrectCredentials,true);
                }

                await Utils.setToken(token);

                Profile person = await PersonsService().getSignedInPerson();

                if(widget._isSupplier){
                  if(!person.scope.contains('supplier')){
                    Navigator.pop(context);
                    showSimpleSnackbar(scaffoldKey, lang.notASupplier,true);
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
                    showSimpleSnackbar(scaffoldKey, lang.notADriver,true);
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
                    CustomNavigator.pushReplacement(context, DriverHomePage());
                  }else{
                    CustomNavigator.pushReplacement(context, WaitingApproval());
                  }
                }

              },
              child: Column(children: <Widget>[
                HeaderView(
                  title: lang.signIn,
                  subtitle: lang.enterCredentials,
                ),
                ContactInputField((value, status) {
                  _username.text = value;
                  if(status!=isPhoneValid){
                    isPhoneValid = status;
                    setState(() {

                    });
                  }
                }),
                // HaweyatiPhoneField(
                //     controller: _username,
                //     label: lang.yourPhone,
                //     //todo: uncomment validator on production
                //     validator: (value) => phoneValidator(value),
                //   ),
                  SizedBox(height: 20),
                  HaweyatiPasswordField(
                    context: context,
                    label: lang.yourPassword,
                    controller: _password,
                    // validator: (value) => emptyValidator(value,lang.yourPassword),
                  ),
                  Align(
                    alignment: Alignment(1, 1),
                    child: GestureDetector(
                      onTap: () async  {
                      String verifiedNumber = await CustomNavigator.navigateTo(context, PreSignUpPhoneVerifier(forgotPassword: true,));

                      if(verifiedNumber!=null){
                        CustomNavigator.navigateTo(context, ResetPasswordPage(phoneNumber: verifiedNumber,));
                      }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(lang.forgotPassword, style: TextStyle(
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
                          child: Text(lang.registerNow, style: TextStyle(
                            color: Theme.of(context).accentColor
                          )),
                        ),
                      ),
                    ),

                  ])
                ]))),


            ),
        ),
        ),
    );
  }
}
