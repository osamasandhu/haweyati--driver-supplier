
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:haweyati_supplier_driver_app/widgits/image.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';


class AddDumpster extends StatefulWidget {
  @override
  _AddDumpsterState createState() => _AddDumpsterState();
}

class _AddDumpsterState extends State<AddDumpster> {



  @override
  Widget build(BuildContext context) {



    return ScrollablePage(
      
      appBar: HaweyatiAppBar(),
      title: "Add Dumpster",
      subtitle: loremIpsum.substring(0,35),
      showButtonBackground: true,
      action: "Submit",onAction: (){Navigator.of(context).pop();},
      child: SliverPadding(padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
        sliver : SliverList( delegate: SliverChildListDelegate( [

          HaweyatiTextField(label: "Size",keyboardType: TextInputType.phone,),
SizedBox(height: 15,),
          TextFormField(
              scrollPadding: EdgeInsets.only(bottom: 150),
              maxLength: 180,
              maxLines: 5,
              decoration: InputDecoration(
                  labelText: "Description",

                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 2)))
          ),
          Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),


          SizedBox(height: 30),
PickImage(),

          SizedBox(height: 25),

          Text("Pricing",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

          SizedBox(height: 25),


          Row(children: <Widget>[

            Expanded(child: HaweyatiTextField( label: "City",)),SizedBox(width: 10,)
            ,Expanded(child: HaweyatiTextField( label: "Rent",keyboardType: TextInputType.phone,))

          ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          SizedBox(height: 25),



          Row(children: <Widget>[

            Expanded(child: HaweyatiTextField( label: "Days",keyboardType: TextInputType.phone,)),SizedBox(width: 10,)
            ,Expanded(child: HaweyatiTextField( label: "Extra Days",keyboardType: TextInputType.phone,))

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
