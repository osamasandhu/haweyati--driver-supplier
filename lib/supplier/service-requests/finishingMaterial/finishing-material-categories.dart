import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/models/finishing-material_category.dart';
import 'package:haweyati_supplier_driver_app/src/services/finishing-material_service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/service-list-item.dart';

import 'finishing-material-products.dart';

class FinishingMaterialCategories extends StatefulWidget {
  @override
  _FinishingMaterialCategoriesState createState() => _FinishingMaterialCategoriesState();
}

class _FinishingMaterialCategoriesState extends State<FinishingMaterialCategories> {

  var _service = FinishingMaterialService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HaweyatiAppBar(),
        backgroundColor: Colors.white,
        body: LiveScrollableView<FinishingMaterialCategory>(
          title: 'Available Finishing Material Categories',
          subtitle: '',
          loader: ()=> _service.getFinishingMaterial(),
          builder: (context,data){
            return ServiceListItem(
              onTap: (){
                CustomNavigator.navigateTo(context, FinishingMaterialProducts(parent: data,));
              },
              name: data.name,
              image: data.image.name,
            );
          },
        )
    );
  }
}