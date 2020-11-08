import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/models/finishing-material_category.dart';
import 'package:haweyati_supplier_driver_app/model/models/finishing-product.dart';
import 'package:haweyati_supplier_driver_app/src/services/fn-product_service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/live-scrollable_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/service-list-item.dart';

import 'add-finishing-Materail.dart';

class FinishingMaterialProducts extends StatefulWidget {
  final FinishingMaterialCategory parent;
  FinishingMaterialProducts({this.parent});
  @override
  _FinishingMaterialProductsState createState() => _FinishingMaterialProductsState();
}

class _FinishingMaterialProductsState extends State<FinishingMaterialProducts> {

  var _service = FinishingMaterialProductService();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       Scaffold(
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              foregroundColor: Colors.white,
              onPressed: () => CustomNavigator.navigateTo(context, FinishingMaterialRequest(parent: widget.parent))
          ),
          appBar: HaweyatiAppBar(),
          backgroundColor: Colors.white,
          body: LiveScrollableView<FinProduct>(
            title: '${lang.available} ${widget.parent.name} ${lang.products}',
            subtitle: '',
            loader: ()=> _service.getFinSublist(widget.parent.sId),
            builder: (context,data){
              return ServiceListItem(
                onTap: (){
                  // CustomNavigator.navigateTo(context, BuildingMaterialProducts(parent: data,));
                },
                name: data.name,
                image: data.images.name,
              );
            },
          )
      ),
    );
  }
}