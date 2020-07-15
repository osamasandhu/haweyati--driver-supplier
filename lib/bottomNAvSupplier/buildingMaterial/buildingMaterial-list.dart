import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/buildingMaterial/add-buildingmaterial.dart';
import 'package:haweyati_supplier_driver_app/model/building-material-Model.dart';
import 'package:haweyati_supplier_driver_app/services/building-material-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';

import 'buildingSublist.dart';

class BuildingMaterialList extends StatefulWidget {
  @override
  _BuildingMaterialListState createState() => _BuildingMaterialListState();
}

class _BuildingMaterialListState extends State<BuildingMaterialList> {

  Future <List<BuildingMaterialModel>> buildingMaterial;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    buildingMaterial =BuildingMaterialServices().getBuildingMaterial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(
        context: context,
      onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBuildingMaterial()));},  showadd: true,
      ),
      body: SimpleFutureBuilder.simpler(
          context: context,
          future: buildingMaterial,
          builder:
              (AsyncSnapshot<List<BuildingMaterialModel>> snapshot) {

            if(snapshot.data.length ==0){

            return  Center(child: Text("No Data"),);
            }
            else{
            return ListView.builder(
                itemCount: snapshot.data.length,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(15),
                itemBuilder: (context, index) {
                  var _buildingMaterial = snapshot.data[index];
                  return  ContainerDetailList(ontap: (){CustomNavigator.navigateTo(context, BuildingMaterialSubList(

                    Productid: _buildingMaterial.sId,

                  ));}, name: _buildingMaterial.name,
                      imgpath: "http://192.168.1.105:4000/uploads/${_buildingMaterial.images[0].name}");
                });       }
          })



//      ListView(
//        padding: EdgeInsets.all(15),
//        children: <Widget>[
//          ContainerDetailList(
//            imgpath: "assets/images/sand-1.png",
//            ontap: () {Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
//            },
//            name: "Cement & Gypsum",
//          ),
//          ContainerDetailList(
//            imgpath: "assets/images/sand-2.png",
//            ontap: () {Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
//            },
//            name: "Sand",
//          ),
//          ContainerDetailList(
//            imgpath:  "assets/images/sand-4.png",
//            ontap: () {Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
//            },
//            name: "Block & Related",
//          ),
//          ContainerDetailList(
//            imgpath:  "assets/images/sand-5.png",
//            ontap: () {Navigator.of(context).push(
//                MaterialPageRoute(builder: (context) => BuildingMaterialSubList()));
//            },
//            name: "Gravel",
//          ),
//        ],
//      ),
    );
  }
}
