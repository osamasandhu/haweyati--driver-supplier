import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/buildingMaterial/buildingSublist.dart';
import 'package:haweyati_supplier_driver_app/model/finishing-material-Model.dart';
import 'package:haweyati_supplier_driver_app/services/finishing-material-Service.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';


class FinishingMaterialSubList extends StatefulWidget {
 String finshId;
 FinishingMaterialSubList({this.finshId});

  @override
  _FinishingMaterialSubListState createState() => _FinishingMaterialSubListState();
}

class _FinishingMaterialSubListState extends State<FinishingMaterialSubList> {

  Future <List<FinishingMaterialModel>> finish;

  @override
  void initState() {
    super.initState();
   finish = FinishingMaterialSerivce().getFinishings(widget.finshId);}


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: HaweyatiAppBar(context: context,showadd: true,),body:
    SimpleFutureBuilder.simpler(
        context: context,
        future: finish,
        builder:
            (AsyncSnapshot<List<FinishingMaterialModel>> snapshot) {

          if(snapshot.data.length ==0){

            return    Center(child: Text("No Data "),);
          }

          else{
            return

              ListView.builder(
                  itemCount: snapshot.data.length,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(15),
                  itemBuilder: (context, index) {
                    var _finish = snapshot.data[index];
                    return  ContainerDetailList(
                        ontap: (){
//                          CustomNavigator.navigateTo(context, BuildingMaterialSubList(
//
//
//                    )
//                        );
                          }, name: _finish.name,imgpath: "$apiUrl/uploads/${_finish.images[0].name}");
                  });}
        })



//        ListView(padding: EdgeInsets.all(15), children: <Widget>[
//      ContainerDetailList(imgpath: "assets/images/item-2.png",ontap: (){},name: "Maepil",),
//
//
//
//    ],),
    );
  }
}
