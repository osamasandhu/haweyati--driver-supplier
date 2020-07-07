import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/add-finishingMaterail.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';

import 'finishingSublist.dart';


class FinsihingList extends StatefulWidget {
  @override
  _FinsihingListState createState() => _FinsihingListState();
}

class _FinsihingListState extends State<FinsihingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: HaweyatiAppBar(context: context,showadd: true,onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddFinishingMaterial()));},),body: ListView(padding: EdgeInsets.all(15),children: <Widget>[
      ContainerDetailList(imgpath:  "assets/images/item-1.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FinishingMaterialSubList()));
      },name: "Wall Finishies",),
      ContainerDetailList(imgpath: "assets/images/item-3.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FinishingMaterialSubList()));
      },name: "Ceiling Finishies",),
      ContainerDetailList(imgpath: "assets/images/item-2.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FinishingMaterialSubList()));
      },name: "Floor Finishies",),
      ContainerDetailList(imgpath:"assets/images/item-5.png",ontap: (){Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => FinishingMaterialSubList()));
      },name: "Roof Finishies",),



    ],),);
  }
}
