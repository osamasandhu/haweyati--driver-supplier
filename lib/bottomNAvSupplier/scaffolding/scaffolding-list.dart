import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/scaffolding/scaffoldingSublist.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class ScaffoldingList extends StatefulWidget {
  @override
  _ScaffoldingListState createState() => _ScaffoldingListState();
}

class _ScaffoldingListState extends State<ScaffoldingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,),body: ListView(padding: EdgeInsets.all(15),children: <Widget>[
      ContainerDetailList(imgpath: "assets/images/pantedScaffolding.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ScaffoldingSubList()));
      },name: "Steel Scaffolding",),
      ContainerDetailList(imgpath: "assets/images/pantedScaffolding.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ScaffoldingSubList()));},name: "Patented Scaffolding",),
      ContainerDetailList(imgpath: "assets/images/pantedScaffolding.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ScaffoldingSubList()));},name: "Single Scaffolding",),



    ],),);
  }
}
