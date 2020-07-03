import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class BuildingMaterialSubList extends StatefulWidget {
  @override
  _BuildingMaterialSubListState createState() => _BuildingMaterialSubListState();
}

class _BuildingMaterialSubListState extends State<BuildingMaterialSubList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,showadd: true,),body: ListView(padding: EdgeInsets.all(15), children: <Widget>[
      ContainerDetailList(imgpath:  "assets/images/sand-1.png",ontap: (){},name: "Fine Sand",),



    ],),);
  }
}
