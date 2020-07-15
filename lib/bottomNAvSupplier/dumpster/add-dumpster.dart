
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/model/dumpster-Model.dart';
import 'package:haweyati_supplier_driver_app/model/order-location_model.dart';
import 'package:haweyati_supplier_driver_app/model/service-post_model.dart';
import 'package:haweyati_supplier_driver_app/model/supplier-Model.dart';
import 'package:haweyati_supplier_driver_app/services/haweyati-supplier-driver-service.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/emptyContainer.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:haweyati_supplier_driver_app/widgits/image.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locations-map_page.dart';


class AddDumpster extends StatefulWidget {
  @override
  _AddDumpsterState createState() => _AddDumpsterState();
}

class _AddDumpsterState extends State<AddDumpster> {
  TextEditingController size=TextEditingController();
  TextEditingController helperPrice=TextEditingController();

  TextEditingController discrp=TextEditingController();
//  TextEditingController city=TextEditingController();
  TextEditingController rent=TextEditingController();
  TextEditingController day=TextEditingController();
  TextEditingController extraDay=TextEditingController();
  SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    initMap();
  }

  initMap() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePage(
      appBar: HaweyatiAppBar(),
      title: "Add Dumpster",
      subtitle: loremIpsum.substring(0,35),
      showButtonBackground: true,
      action: "Submit",onAction: () async {

        ServicePostModel model = ServicePostModel(
          suppliers: '5f0c42cee4d1b9205474c0ae',
          type: 'Construction Dumpster',
          data: DumspterModel(
              size: size.text,
              description: discrp.text,
              pricing:[
                Pricing(
                    city: prefs.getString('city'),
                    extraDayRent: int.parse(extraDay.text),
                    helperPrice: int.parse(helperPrice.text),
                    rent: int.parse(rent.text),
                    days: int.parse(day.text)
                )
              ]
          )
        );

        print(model.toJson());
        var dumpsterdata = await Dio().post('$apiUrl/service-requests',data: model.toJson());
        print(dumpsterdata.data);

//      FormData dumpsterData = FormData.fromMap(dumpster.toJson());
    },
      child: SliverPadding(padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
        sliver : SliverList( delegate: SliverChildListDelegate( [

          HaweyatiTextField(label: "Size",controller: size, keyboardType: TextInputType.phone,),
SizedBox(height: 15,),
          TextFormField(controller: discrp,
              scrollPadding: EdgeInsets.only(bottom: 150),
              maxLength: 180,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: "Description",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2)))
          ),


//          SizedBox(height: 30),
//PickImage(),

          SizedBox(height: 25),

          Text("Pricing",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
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


          Row(children: <Widget>[

            Expanded(child:
            HaweyatiTextField( label: "Helper Price",controller: helperPrice,)
            ),
            SizedBox(width: 10,)
            ,Expanded(child: HaweyatiTextField( label: "Rent",controller: rent, keyboardType: TextInputType.phone,))

          ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          SizedBox(height: 25),



          Row(children: <Widget>[

            Expanded(child: HaweyatiTextField( label: "Days" ,controller: day, keyboardType: TextInputType.phone,)),SizedBox(width: 10,)
            ,Expanded(child: HaweyatiTextField( label: "Extra Days",controller: extraDay, keyboardType: TextInputType.phone,))

          ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          SizedBox(height: 25),


          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),IconButton(icon: Icon( Icons.search,color: Theme.of(context).primaryColor,size:30,), onPressed:(){

                print("Search");
              })
            ],
          ),

        ])),
      ),
    );
  }
}
