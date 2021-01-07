import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/drawer-item.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/localization-selector.dart';
import 'package:haweyati_supplier_driver_app/widgits/rating-bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../web-sockets-testing.dart';
import 'supplier-profile_page.dart';

class SupplierDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) =>  Drawer(child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Color(0xff313f53),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: LocalizationSelector(),
          ),
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AppData.supplier.person.image == null ? AssetImage("assets/images/icon.png") :
              NetworkImage(HaweyatiService.resolveImage(AppData.supplier.person.image.name)),
            ),
          ),
          SizedBox(height: 10),
          Center(child: Text(AppData.supplier?.person?.name ?? '', style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold
          ))),
          StarRating(
            padding: EdgeInsets.symmetric(vertical: 5),
            color: Colors.yellow,
            rating: 0,
            size: 20,
            // onRatingChanged: (rating) => setState(() => this.rating = rating),
          ),
          SizedBox(height: 10),

          Expanded(child: SingleChildScrollView(child: Column(children: <Widget>[
            // DrawerItem(icon: CupertinoIcons.home, text: 'Home', onTap: () => Navigator.of(context).pop()),
            DrawerItem(icon: CupertinoIcons.person, text: lang.settings, onTap: () {
              CustomNavigator.navigateTo(context, SupplierProfile());
            }),
            // DrawerItem(icon: Icons.monetization_on, text: 'Completed Orders', onTap: () => Navigator.of(context).pop()),

            DrawerItem(
                text: lang.serviceRequests,
                icon: Icons.business,
                onTap: () async {
                  await Navigator.of(context).pop();
                  // CustomNavigator.navigateTo(context, WebSocketsTesting());
                  Navigator.of(context).pushNamed('/supplier-services');
                }
            ),

            DrawerItem(icon: Icons.star, text: lang.rateApp, onTap: () => Navigator.of(context).pop()),

            // DrawerItem(icon: CupertinoIcons.news, text: 'Reports', onTap: () => Navigator.of(context).pop()),
            // DrawerItem(icon: CupertinoIcons.car, text: 'Driver', onTap: () => Navigator.of(context).pop()),
            DrawerItem(
                text: lang.logout,
                icon: Icons.exit_to_app,
                onTap: () async {
                  openLoadingDialog(context, lang.signingOut);
                  await AppData.signOut();
                  CustomNavigator.pushReplacement(context, PreSignInPage());
                }
            ),
          ]))),
        ], crossAxisAlignment: CrossAxisAlignment.start),
      )),
    );
  }
}
