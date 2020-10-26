import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/drawer-item.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/localization-selector.dart';

import 'supplier-profile_page.dart';

class SupplierDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(child: Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Color(0xff313f53),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: LocalizationSelector(
            selected: Locale('en'),
            onChanged: (locale) {},
          ),
        ),
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AppData.supplier.person.image == null ? AssetImage("assets/images/icon.png") :
            NetworkImage(HaweyatiService.resolveImage(AppData.supplier.person.image.name)),
          ),
        ),
        SizedBox(height: 15),
        Center(child: Text(AppData.supplier?.person?.name ?? '', style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold
        ))),

        SizedBox(height: 10),

        Expanded(child: SingleChildScrollView(child: Column(children: <Widget>[
          // DrawerItem(icon: CupertinoIcons.home, text: 'Home', onTap: () => Navigator.of(context).pop()),
          DrawerItem(icon: CupertinoIcons.person, text: 'Account', onTap: () {
            CustomNavigator.navigateTo(context, SupplierProfile());
          }
          ),
          // DrawerItem(icon: Icons.monetization_on, text: 'Completed Orders', onTap: () => Navigator.of(context).pop()),

          DrawerItem(
              text: 'Service Requests',
              icon: Icons.business,
              onTap: () async {
                await Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/supplier-services');
              }
          ),
          DrawerItem(icon: Icons.star, text: 'Rate App', onTap: () => Navigator.of(context).pop()),

          // DrawerItem(icon: CupertinoIcons.news, text: 'Reports', onTap: () => Navigator.of(context).pop()),
          // DrawerItem(icon: CupertinoIcons.car, text: 'Driver', onTap: () => Navigator.of(context).pop()),
          DrawerItem(
              text: 'Sign Out',
              icon: Icons.exit_to_app,
              onTap: () async {
                openLoadingDialog(context, "Signing out");
                await AppData.signOut();
                CustomNavigator.pushReplacement(context, PreSignInPage());
              }
          ),
        ]))),
      ], crossAxisAlignment: CrossAxisAlignment.start),
    ));
  }
}
