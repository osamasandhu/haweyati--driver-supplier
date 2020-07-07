import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/buildingMaterial/add-buildingmaterial.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';

import 'buildingSublist.dart';

class BuildingMaterialList extends StatefulWidget {
  @override
  _BuildingMaterialListState createState() => _BuildingMaterialListState();
}

class _BuildingMaterialListState extends State<BuildingMaterialList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(
        context: context,
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBuildingMaterial()));},  showadd: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: <Widget>[
          ContainerDetailList(
            imgpath: "assets/images/sand-1.png",
            ontap: () {Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
            },
            name: "Cement & Gypsum",
          ),
          ContainerDetailList(
            imgpath: "assets/images/sand-2.png",
            ontap: () {Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
            },
            name: "Sand",
          ),
          ContainerDetailList(
            imgpath:  "assets/images/sand-4.png",
            ontap: () {Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
            },
            name: "Block & Related",
          ),
          ContainerDetailList(
            imgpath:  "assets/images/sand-5.png",
            ontap: () {Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
            },
            name: "Gravel",
          ),
        ],
      ),
    );
  }
}
