import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/models/building-material_sublist.dart';
import 'package:haweyati_supplier_driver_app/model/building-material-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/bm-sublist_service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/service-list-item.dart';

import 'add-buildingmaterial.dart';

class BuildingMaterialProducts extends StatefulWidget {
  final BuildingMaterialModel parent;
  BuildingMaterialProducts({this.parent});
  @override
  _BuildingMaterialProductsState createState() => _BuildingMaterialProductsState();
}

class _BuildingMaterialProductsState extends State<BuildingMaterialProducts> {

  var _service = BMSublistService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HaweyatiAppBar(),
      backgroundColor: Colors.white,
      body: LiveScrollableView<BMProduct>(
        title: 'Available ${widget.parent.name} Products',
        subtitle: '',
        loader: ()=> _service.getBMSublist(widget.parent.sId),
        builder: (context,data){
          return ServiceListItem(
            onTap: (){
              // CustomNavigator.navigateTo(context, widget);
            },
            name: data.name,
            image: data.image.name,
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          foregroundColor: Colors.white,
          onPressed: () => CustomNavigator.navigateTo(context, BuildingMaterialRequest(category: widget.parent,))
      ),
    );
  }
}