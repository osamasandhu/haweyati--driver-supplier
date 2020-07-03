import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class DumpsterList extends StatefulWidget {
  @override
  _DumpsterListState createState() => _DumpsterListState();
}

class _DumpsterListState extends State<DumpsterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,),body: ListView(padding: EdgeInsets.all(15),children: <Widget>[
      ContainerDetailList(imgpath: "assets/images/dumpster-12.png",ontap: (){},name: "20 Yard Dumpster",),
      ContainerDetailList(imgpath: "assets/images/dumpster.png",ontap: (){},name: "12 Yard Dumpster",)



    ],),);
  }
}
