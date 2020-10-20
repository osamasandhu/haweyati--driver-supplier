import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/common/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/persons-service.dart';
import 'package:haweyati_supplier_driver_app/src/pre-sign-up-phone-verification.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/supplier/auth-pages/supplier-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';

class PreSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Center(child: Image.asset("assets/images/icon.png", height: 200))
          ),
          Spacer(flex: 2),
          _buildButton(
            onTap: () async {
              String verifiedPhoneNumber = await CustomNavigator.navigateTo(context, PreSignUpPhoneVerifier());

            if(verifiedPhoneNumber!=null){
              openLoadingDialog(context, "Processing");
              try {
                PersonModel person = await PersonsService().getPersonByContact(
                    verifiedPhoneNumber);
                Navigator.pop(context);
                if (person != null) {
                  if(person.scope.contains('driver')){
                    openMessageDialog(context, "A Supplier with this phone number already exists.");
                    return;
                  }
                  bool confirm = await showDialog(context: context,
                      builder: (context) {
                        return ConfirmationDialog(message: 'A ${person.scope
                            .first} profile already exists with this phone number.'
                            'Are you sure you want to sync these accounts?',);
                      });
                  if (confirm ?? false) {
                    CustomNavigator.navigateTo(context, DriverSignUpPage(
                      phoneNumber: verifiedPhoneNumber, person: person,));
                  }
                }
              } catch (e){
                Navigator.of(context).pop();
                CustomNavigator.navigateTo(context, DriverSignUpPage(phoneNumber: verifiedPhoneNumber,));
              }
            }
            },
            btnName: "SIGNUP AS DRIVER",
            color: Theme.of(context).accentColor
          ),

          SizedBox(height: 20),

          _buildButton(
            onTap: () async {
             String verifiedPhoneNumber = await CustomNavigator.navigateTo(context, PreSignUpPhoneVerifier());

              if(verifiedPhoneNumber!=null){
                openLoadingDialog(context, "Processing");
                try {
                  PersonModel person = await PersonsService()
                      .getPersonByContact(verifiedPhoneNumber);
                  Navigator.pop(context);
                  if (person != null) {
                    if(person.scope.contains('supplier')){
                      openMessageDialog(context, "A Supplier with this phone number already exists.");
                      return;
                    }
                    bool confirm = await showDialog(context: context,
                        builder: (context) {
                          return ConfirmationDialog(message: 'A ${person.scope
                              .first} profile already exists with this phone number.'
                              'Are you sure you want to sync these accounts?',);
                        });
                    if (confirm ?? false) {
                      CustomNavigator.navigateTo(context, SupplierSignUpPage(
                        phoneNumber: verifiedPhoneNumber, person: person,));
                    }
                  }
                } catch (e){
                  CustomNavigator.navigateTo(context, SupplierSignUpPage(phoneNumber: verifiedPhoneNumber,));
                }
              }
            },
            btnName: "SIGNUP AS SUPPLIER ",
            color: Theme.of(context).primaryColor
          ),

          SizedBox(height: 40),

          GestureDetector(
            child: Text("LOGIN NOW", style: TextStyle(color: Colors.grey)),
            onTap: () => Navigator.of(context).pop()
          ),

          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildButton({String btnName, Function onTap, Color color}) {
    return SizedBox(
      width: 300,
      height: 55,
      child: FlatButton(
        child: Text(btnName),
        shape: StadiumBorder(),
        color: color,
        textColor: Colors.white,
        onPressed: onTap
      ),
    );
  }
}
