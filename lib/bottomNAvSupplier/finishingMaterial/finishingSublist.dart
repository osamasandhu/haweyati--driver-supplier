import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class FinishingMaterialSubList extends StatefulWidget {
  @override
  _FinishingMaterialSubListState createState() => _FinishingMaterialSubListState();
}

class _FinishingMaterialSubListState extends State<FinishingMaterialSubList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,showadd: true,),body: ListView(padding: EdgeInsets.all(15), children: <Widget>[
      ContainerDetailList(imgpath: "assets/images/item-2.png",ontap: (){},name: "Maepil",),



    ],),);
  }
}
