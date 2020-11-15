

import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/driver/edit-driver-profile.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/pre-sign-in_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/change-password.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/rating-bar.dart';

class DriverDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context, lang) => Drawer(child: Container(
        color: Color(0xff313f53),
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Column(children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(child: Column(children: <Widget>[
                Center(child: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.white,
                  radius: 50,
                  backgroundImage: AppData.driver.profile.image !=null
                      ? NetworkImage(
                      HaweyatiService.convertImgUrl(AppData.driver.profile.image.name)) :
                  AssetImage("assets/images/icon.png"),
                )),
                SizedBox(height: 15),
                Center(child: Text(AppData?.driver?.profile?.name ?? '', textAlign: TextAlign.center, style: TextStyle(
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
                  // onRatingChanged: (rating) => setState(() => this.rating = rating),
                ),
              ])),
            ),

            SizedBox(height: 10),

            Expanded(child: SingleChildScrollView(
              child: Column(children: <Widget>[
                // _buildListTile(
                //     title: "Home",
                //     icon: Icons.home,
                //     onTap: () {
                //       Navigator.of(context).pop();
                //     }
                // ),
                _buildListTile(
                    title: lang.myProfile,
                    onTap: () {
                      CustomNavigator.navigateTo(context, EditDriverProfile());
                    },
                    icon: Icons.person
                ),
                // _buildListTile(
                //     title: lang.completedOrders,
                //     onTap: () {
                //       /*CustomNavigator.navigateTo(context, DriverCompletedOrders());*/
                //     },
                //     icon: Icons.format_list_numbered
                // ),
                _buildListTile(
                    title: lang.changePassword,
                    onTap: () {
                      CustomNavigator.navigateTo(context, ChangePassword());
                    },
                    icon: Icons.lock
                ),
                _buildListTile(
                    title: lang.logout,
                    onTap: () async {
                      openLoadingDialog(context, lang.signingOut);
                      await AppData.signOut();
                      CustomNavigator.pushReplacement(context, PreSignInPage());
                    },
                    icon: Icons.exit_to_app
                )
              ]),
            ))
          ], crossAxisAlignment: CrossAxisAlignment.start),
        ),
      )),
    );
  }

  Widget _buildListTile({IconData icon, String title, Function onTap}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon,color: Colors.white, size: 30),
      title: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
