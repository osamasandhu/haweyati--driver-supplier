import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/scaffolding/scaffoldingSublist.dart';
import 'package:haweyati_supplier_driver_app/model/scaffolding-model.dart';
import 'package:haweyati_supplier_driver_app/services/scaffolding-Service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';


class ScaffoldingList extends StatefulWidget {
  @override
  _ScaffoldingListState createState() => _ScaffoldingListState();
}

class _ScaffoldingListState extends State<ScaffoldingList> {
  Future<List<ScaffoldingModel>> scaffolding;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 scaffolding =ScaffoldingServices().getScaffolding();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,),body:SimpleFutureBuilder.simpler(
        context: context,
        future: scaffolding,
        builder:
            (AsyncSnapshot<List<ScaffoldingModel>> snapshot) {
          return ListView.builder(
              itemCount: snapshot.data.length,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var _scaffolding = snapshot.data[index];
                return  ContainerDetailList(name: _scaffolding.type,
                    imgpath: "http://192.168.1.109:4000/uploads/${_scaffolding.suppliers}");
              });})

    );
  }
}
