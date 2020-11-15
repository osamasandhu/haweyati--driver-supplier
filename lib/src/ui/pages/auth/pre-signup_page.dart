import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/profile_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/persons-service.dart';
import 'package:haweyati_supplier_driver_app/src/supplier/auth-pages/supplier-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-sign-up_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/no-scroll_page.dart';
import 'package:haweyati_supplier_driver_app/widgits/confirmation-dialog.dart';

import '../../../pre-sign-up-phone-verification.dart';

class PreSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) => NoScrollPage(
        body: DottedBackgroundView(
          child: Column(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Center(child: Image.asset("assets/images/icon.png", height: 200))
                ),
                Spacer(flex: 2),
                _buildButton(
                  onTap: () async {
                    // Todo: For Testing
                    // String verifiedPhoneNumber = "+966535551047";

                    // String verifiedPhoneNumber = DateTime.now().toIso8601String();
                    //
                    String verifiedPhoneNumber = await CustomNavigator.navigateTo(context, PreSignUpPhoneVerifier());

                  if(verifiedPhoneNumber!=null){
                    openLoadingDialog(context, lang.processing);
                    try {
                      Profile person = await PersonsService().getPersonByContact(
                          verifiedPhoneNumber);
                      Navigator.pop(context);
                      if (person != null) {
                        if(person.scope.contains('driver')){
                          openMessageDialog(context, lang.alreadyExistsDriver);
                          return;
                        }
                        bool confirm = await showDialog(context: context,
                            builder: (context) {
                              return ConfirmationDialog(title: Text('${person?.scope
                                  ?.first?.toUpperCase() ?? 'Profile'} ${lang.alreadyExistsProfile}'));
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
                  btnName: lang.signUpAsDriver,
                  color: Theme.of(context).accentColor
                ),

                SizedBox(height: 20),

                _buildButton(
                  onTap: () async {
                    // Todo: For Testing
                    // String verifiedPhoneNumber = "+966535551047";

                    String verifiedPhoneNumber = await CustomNavigator.navigateTo(context, PreSignUpPhoneVerifier());

                    if(verifiedPhoneNumber!=null){
                      openLoadingDialog(context, lang.processing);
                      try {
                        Profile person = await PersonsService()
                            .getPersonByContact(verifiedPhoneNumber);
                        Navigator.pop(context);
                        if (person != null) {
                          if(person.scope.contains('supplier')){
                            openMessageDialog(context, lang.alreadyExistsSupplier);
                            return;
                          }
                          bool confirm = await showDialog(context: context,
                              builder: (context) {
                                return ConfirmationDialog(title: Text('${person?.scope
                                    ?.first?.toUpperCase() ?? 'Profile'} ${lang.alreadyExistsProfile}'));
                              });
                          if (confirm ?? false) {
                            CustomNavigator.navigateTo(context, SupplierSignUpPage(
                              phoneNumber: verifiedPhoneNumber, person: person,));
                          }
                        }
                      } catch (e){
                        Navigator.pop(context);
                        CustomNavigator.navigateTo(context, SupplierSignUpPage(phoneNumber: verifiedPhoneNumber,));
                      }
                    }
                  },
                  btnName: lang.signUpAsSupplier,
                  color: Theme.of(context).primaryColor
                ),

                SizedBox(height: 40),

                GestureDetector(
                  child: Text(lang.signIn, style: TextStyle(color: Colors.grey)),
                  onTap: () => Navigator.of(context).pop()
                ),

                SizedBox(height: 20)
              ],
          ),
        ),
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
