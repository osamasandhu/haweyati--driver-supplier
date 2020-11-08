import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/driver-supplier-map.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/change-password.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';

import 'edit-supplier-profile.dart';


class SupplierProfile extends StatefulWidget {
  @override
  _SupplierProfileState createState() => _SupplierProfileState();
}
class _SupplierProfileState extends State<SupplierProfile> {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang)=> Scaffold(
        appBar: HaweyatiAppBar(hideHome: true,),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
          child: Column(
            children: <Widget>[
              Center(
                  child: CircleAvatar(
                radius: 65,
                    backgroundImage: AppData.supplier.person.image == null ? AssetImage("assets/images/icon.png") :
                    NetworkImage(HaweyatiService.resolveImage(AppData.supplier.person.image.name)),
              )),
              SizedBox(
                height: 15,
              ),
              Text(
                AppData.supplier.person.name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(lang.account,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              )
,
              _buildListTile(iconData: Icons.edit,title: lang.editProfile,onTap: () async {
              await  CustomNavigator.navigateTo(context, EditSupplierProfile());
              setState(() {

              });
              }),
          _buildListTile(iconData: Icons.lock,title: lang.changePassword,onTap: () async {
            CustomNavigator.navigateTo(context, ChangePassword());
          }),
             // _buildListTile(title: "Map",onTap: (){
             //    CustomNavigator.navigateTo(context, DriverRouteMapPage());
             //  },iconData: Icons.location_on),
             //  _buildListTile(iconData: Icons.theaters,title: "Theme",onTap: (){}),
             //  ListTile(
             //    title: Text("Options",
             //        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
             //  )
             //  ,_buildListTile(iconData: Icons.lock,title: "Privacy Policy",onTap: (){}),
             //  _buildListTile(iconData: Icons.aspect_ratio,title: "Rate Us",onTap: (){}),
             //  _buildListTile(iconData: Icons.help,title: "Help",onTap: (){}),

            ],
          ),
        ),
      ),
    );

  }
  Widget _buildListTile({String title,IconData iconData,Function onTap}){
    return ListTile(leading: Icon(iconData),trailing: Icon(Icons.arrow_forward_ios),
      title: Text(title,style: TextStyle(fontWeight: FontWeight.w400),),
      onTap: onTap,
    );
  }

}


