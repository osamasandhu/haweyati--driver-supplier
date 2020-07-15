import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/dumpster/add-dumpster.dart';
import 'package:haweyati_supplier_driver_app/model/dumpster-Model.dart';
import 'package:haweyati_supplier_driver_app/services/dumpster-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class DumpsterList extends StatefulWidget {
  @override
  _DumpsterListState createState() => _DumpsterListState();

  }

  class _DumpsterListState extends State<DumpsterList> {


  Future<List<DumspterModel>> dumpster;
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dumpster =DumpsterServices().getDumpster();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(
        context: context,
        showadd: true,
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context)=>AddDumpster()));},),
      body:SimpleFutureBuilder.simpler(
          context: context,
          future: dumpster,
          builder:
              (AsyncSnapshot<List<DumspterModel>> snapshot) {
            return ListView.builder( 
                itemCount: snapshot.data.length,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  var _dumpster = snapshot.data[index];
                  return  ContainerDetailList(name: _dumpster.size,imgpath: "http://192.168.1.105:4000/uploads/${_dumpster.images[0].name}");
                });
          }),


//      ListView(padding: EdgeInsets.all(15),children: <Widget>[
//      ContainerDetailList
//        (
//        imgpath: "assets/images/dumpster-12.png",
//        ontap: (){},
//        name: "20 Yard Dumpster",),
//      ContainerDetailList(imgpath: "assets/images/dumpster.png",ontap: (){},name: "12 Yard Dumpster",)
//
//
//
//    ],),
    );
  }
}
