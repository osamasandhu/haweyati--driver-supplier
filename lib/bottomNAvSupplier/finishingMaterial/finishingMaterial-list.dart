import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/finishing-material-Model.dart';
import 'package:haweyati_supplier_driver_app/services/finishing-material-Service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-future-builder.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/container-main.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';

import 'add-finishing-Materail.dart';
import 'finishingSublist.dart';


class FinsihingList extends StatefulWidget {
  @override
  _FinsihingListState createState() => _FinsihingListState();
}

class _FinsihingListState extends State<FinsihingList> {



  Future <List<FinishingMaterialModel>> finishingMaterial;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finishingMaterial =FinishingMaterialSerivce().getFishingMaterial();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: HaweyatiAppBar(context: context,showadd: true,onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddFinishingMaterial()));},),body:

    SimpleFutureBuilder.simpler(
        context: context,
        future: finishingMaterial,
        builder:
            (AsyncSnapshot<List<FinishingMaterialModel>> snapshot) {


              if(snapshot.data.length ==0){

                return  Center(child: Text("No Data"),);
              }
        else{
          return ListView.builder(
              itemCount: snapshot.data.length,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              itemBuilder: (context, index) {
                var _finishingMaterial = snapshot.data[index];
                return  ContainerDetailList(ontap: (){
                CustomNavigator.navigateTo(context, FinishingMaterialSubList(
                finshId:  _finishingMaterial.sId,
                ));}, name: _finishingMaterial.name,imgpath: "http://192.168.1.105:4000/uploads/${_finishingMaterial.images[0].name}");
              });}
        })

    );
  }
}
