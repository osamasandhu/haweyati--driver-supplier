import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/scaffolding/scaffolding-list.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';

import '../customNa.dart';
import 'buildingMaterial/buildingMaterial-list.dart';
import 'dumpster/dumspter-list.dart';
import 'finishingMaterial/finishingMaterial-list.dart';

class HaweyatiMaterials extends StatefulWidget {
  @override
  _HaweyatiMaterialsState createState() => _HaweyatiMaterialsState();
}

class _HaweyatiMaterialsState extends State<HaweyatiMaterials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,),body: SingleChildScrollView(padding: EdgeInsets.all(10), child: Column(children: <Widget>[



      _buildContainer(
          title:  'Construction_Dumpster',
          imgPath: "assets/images/dumpster-bg.png",
          onTap: () =>

              CustomNavigator.navigateTo(context,DumpsterList())),
      _buildContainer(
          title: 'Scaffolding',
          imgPath: "assets/images/scaffolding-bg.png",
          onTap: () =>
              CustomNavigator.navigateTo(context, ScaffoldingList())),
      _buildContainer(
        title: 'building',
        imgPath: "assets/images/building-materials-bg.png",
        onTap: () =>
            CustomNavigator.navigateTo(context, BuildingMaterialList()),
      ),
      _buildContainer(
        imgPath: "assets/images/finishing-materials-bg.png",
        onTap: () {
          CustomNavigator.navigateTo(
              context,FinsihingList() );
        },
        title: 'Finishing_Materials',
      ),


//      HaweyatiContainer(title: "Construction Dumpster",onTap:
//          (){
//        },
//        imgPath: "sdsds",color: Colors.red[100],)
//  ,    HaweyatiContainer(title: "Scaffolding",onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScaffoldingList()));},imgPath: "sdsds",color: Colors.red[200],)
//   ,   HaweyatiContainer(title: "Building Material",onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BuildingMaterialList()));},imgPath: "sdsds",color: Colors.red[300],)
//    ,  HaweyatiContainer(title: "Finishing Material",onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FinsihingList()));},imgPath: "sdsds",color: Colors.red[400],)


    ],),),);
  }


  Widget _buildListTile(String imgPath, String title,Function onTap) {
    return ListTile(onTap: onTap,dense: true,
      leading: Image.asset(
        imgPath,
        width: 20,
        height: 30,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildContainer(
      {String title, Color color, String imgPath, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        //       margin: EdgeInsets.only(bottom: 1),
        height: 120,
        decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(imgPath),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
//      ),
    );
  }
}
