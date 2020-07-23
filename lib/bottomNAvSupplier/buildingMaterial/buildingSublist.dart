import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/buildingMaterial/add-subbuildingMaterial.dart';
import 'package:haweyati_supplier_driver_app/model/building-material-Model.dart';
import 'package:haweyati_supplier_driver_app/services/building-material-service.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';

class BuildingMaterialSubList extends StatefulWidget {
  String productId;
  BuildingMaterialSubList({this.productId});
  @override
  _BuildingMaterialSubListState createState() =>
      _BuildingMaterialSubListState();
}

class _BuildingMaterialSubListState extends State<BuildingMaterialSubList> {
  Future<List<BuildingMaterialModel>> product;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    product = BuildingMaterialServices().getProdcuts(widget.productId);
    product.then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HaweyatiAppBar(
          context: context,
          showadd: true,onTap: (){
            CustomNavigator.navigateTo(
                context,AddSubBuildingMaterial(subProductId: widget.productId,));},
        ),
        body: SimpleFutureBuilder.simpler(
            context: context,
            future: product,
            builder: (AsyncSnapshot<List<BuildingMaterialModel>> snapshot) {
              if (snapshot.data.length == 0) {
                return Center(
                  child: Text("No Data "),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      var _product = snapshot.data[index];
                      return ContainerDetailList(
                          ontap: () {
                            CustomNavigator.navigateTo(
                                context, BuildingMaterialSubList());
                          },
                          name: _product.name,
                          imgpath:
                              "$apiUrl/uploads/${_product.images[0].name}");
                    });
              }
            }));
  }
}
