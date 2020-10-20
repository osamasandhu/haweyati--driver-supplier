import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class ScaffoldingSubList extends StatefulWidget {
  @override
  _ScaffoldingSubListState createState() => _ScaffoldingSubListState();
}

class _ScaffoldingSubListState extends State<ScaffoldingSubList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(),body: ListView(padding: EdgeInsets.all(15), children: <Widget>[
      ContainerDetailList(imgpath: "sds",ontap: (){},name: "Main Frame",),



    ],),);
  }
}
