import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/building-material-Model.dart';
import 'package:haweyati_supplier_driver_app/model/service-post_model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/emptyContainer.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../locations-map_page.dart';

class AddBuildingMaterial extends StatefulWidget {
  @override
  _AddBuildingMaterialState createState() => _AddBuildingMaterialState();
}

class _AddBuildingMaterialState extends State<AddBuildingMaterial> {
  TextEditingController name = TextEditingController();

  TextEditingController discrp = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController city = TextEditingController();
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initMap();
  }

  initMap() async {
    prefs = await SharedPreferences.getInstance();
    print(prefs.getString('city'));
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return ScrollablePage(
      appBar: HaweyatiAppBar(),
      title: "Add Building Material",
      subtitle: loremIpsum.substring(0, 35),
      showButtonBackground: true,
      action: "Submit",
      onAction: () async {
        ServicePostModel buildingmodel = ServicePostModel(
            suppliers: '5f0c42cee4d1b9205474c0ae',
            type: 'Building Material',

            data: BuildingMaterialModel(
                name: name.text,
                description: discrp.text,
                bmPricing:[
                  Pricing(
                      city: prefs.getString('city'),
                      price: price.text
                  )
                ]

            )
        );

        print(buildingmodel.toJson());

        FormData buildingData = FormData.fromMap(buildingmodel.toJson());

        var res = await Dio().post('$apiUrl/service-requests',data: buildingmodel.toJson());

        print(res);
      },
      child: SliverPadding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
        sliver: SliverList(
            delegate: SliverChildListDelegate([
          HaweyatiTextField(
            label: "Name",
            controller: name,
          ),
          SizedBox(
            height: 15,
          ),
          TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 150),
              maxLength: 180,
              controller: discrp,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2)))),
//          Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//
//
//          SizedBox(height: 30),
//          PickImage(),

          SizedBox(height: 25),

          Text(
            "Pricing",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),


              EmptyContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "City",
//                          style: boldText,
                        ),
                        FlatButton.icon(
                            onPressed: () async {
                              await  Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyLocationMapPage(
                                    editMode: true,
                                  )));
                              setState(() {

                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).accentColor,
                            ),
                            label: Text(
                              "Edit",
                              style:
                              TextStyle(color: Theme.of(context).accentColor),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).accentColor,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(prefs?.getString('city') ?? ''),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
          SizedBox(height: 25),

          Row(
            children: <Widget>[

              Expanded(
                  child: HaweyatiTextField(
                label: "Price",controller:price ,
                keyboardType: TextInputType.phone,
              ))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          SizedBox(height: 25),

//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                "Media",
//                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//              ),
//              IconButton(
//                  icon: Icon(
//                    Icons.search,
//                    color: Theme.of(context).primaryColor,
//                    size: 30,
//                  ),
//                  onPressed: () {
//                    print("Search");
//                  })
//            ],
//          ),
        ])),
      ),
    );
  }
}
