import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/building-material-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/building-material-service.dart';
import 'package:haweyati_supplier_driver_app/src/services/dumpster-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/service-list-item.dart';

import 'building-material-products.dart';

class BuildingMaterialCategories extends StatefulWidget {
  @override
  _BuildingMaterialCategoriesState createState() => _BuildingMaterialCategoriesState();
}

class _BuildingMaterialCategoriesState extends State<BuildingMaterialCategories> {

  var _service = BuildingMaterialCategoriesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(),
      backgroundColor: Colors.white,
      body: LiveScrollableView<BuildingMaterialModel>(
        title: 'Available Building Material Categories',
        subtitle: '',
        loader: ()=> _service.getBuildingMaterial(),
        builder: (context,data){
          return ServiceListItem(
            onTap: (){
              CustomNavigator.navigateTo(context, BuildingMaterialProducts(parent: data,));
            },
            name: data.name,
            image: data.image.name,
          );
        },
      )
    );
  }
}