import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/dark-list-item.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/no-scroll_page.dart';

import 'buildingMaterial/available-building-materials-categories.dart';
import 'finishingMaterial/finishing-material-categories.dart';
import 'scaffolding/scaffolding-request_page.dart';

class SupplierAvailableServicesPage extends StatefulWidget {
  @override
  _SupplierAvailableServicesPageState createState() => _SupplierAvailableServicesPageState();
}

class _SupplierAvailableServicesPageState extends State<SupplierAvailableServicesPage> {
  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       NoScrollPage(
        appBar: HaweyatiAppBar(hideHome: true,),
        body: SingleChildScrollView(child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Text(lang.availableForCall, style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            )),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 40),
          //   child: Text('Lorem Ipsum'),
          // ),
          DarkListItem(
            title: lang.constructionDumpsters,
            trailing: Icon(CupertinoIcons.right_chevron),
            onTap: () => Navigator.of(context).pushNamed('/services-dumpsters')
          ),
          SizedBox(height: 15),
          DarkListItem(
            title: lang.scaffoldings,
            trailing: Icon(CupertinoIcons.right_chevron),
            onTap: () => CustomNavigator.navigateTo(context, ScaffoldingRequest())
          ),
          SizedBox(height: 15),
          DarkListItem(
            title: lang.buildingMaterials,
            trailing: Icon(CupertinoIcons.right_chevron),
            onTap: () => CustomNavigator.navigateTo(context, BuildingMaterialCategories())
          ),
          SizedBox(height: 15),
          DarkListItem(
            title: lang.finishingMaterials,
            trailing: Icon(CupertinoIcons.right_chevron),
            onTap: () => CustomNavigator.navigateTo(context, FinishingMaterialCategories())
          ),
        ]), padding: const EdgeInsets.symmetric(horizontal: 20)),
      ),
    );
//    return Scaffold(
//      appBar: HaweyatiAppBar(),
//      body: SingleChildScrollView(
//        padding: EdgeInsets.all(10),
//        child: Column(children: <Widget>[
//          DarkListItem(title: 'Construction Dumpsters'),
//          DarkListItem(title: 'Scaffolding'),
//          DarkListItem(title: 'Building Materials'),
//          DarkListItem(title: 'Finishing Materials'),
//      _buildContainer(
//          title: '',
//          imgPath: "assets/images/scaffolding-bg.png",
//          onTap: () =>
//              CustomNavigator.navigateTo(context, ScaffoldingList())),
//      _buildContainer(
//        title: 'building',
//        imgPath: "assets/images/building-materials-bg.png",
//        onTap: () =>
//            CustomNavigator.navigateTo(context, BuildingMaterialList()),
//      ),
//      _buildContainer(
//        imgPath: "assets/images/finishing-materials-bg.png",
//        onTap: () {
//          CustomNavigator.navigateTo(
//              context,FinsihingList() );
//        },
//        title: 'Finishing_Materials',
//      ),
//
//
////      HaweyatiContainer(title: "Construction Dumpster",onTap:
////          (){
////        },
////        imgPath: "sdsds",color: Colors.red[100],)
////  ,    HaweyatiContainer(title: "Scaffolding",onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ScaffoldingList()));},imgPath: "sdsds",color: Colors.red[200],)
////   ,   HaweyatiContainer(title: "Building Material",onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BuildingMaterialList()));},imgPath: "sdsds",color: Colors.red[300],)
////    ,  HaweyatiContainer(title: "Finishing Material",onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FinsihingList()));},imgPath: "sdsds",color: Colors.red[400],)
//
//
//    ],),),);
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
