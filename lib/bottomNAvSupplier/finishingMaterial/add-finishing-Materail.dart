import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/add-varient-sheet.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/add-varients.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/customNa.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:haweyati_supplier_driver_app/widgits/image.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';


class AddFinishingMaterial extends StatefulWidget {
  @override
  _AddFinishingMaterialState createState() => _AddFinishingMaterialState();
}

class _AddFinishingMaterialState extends State<AddFinishingMaterial> {
  bool multipleVariants = false;
  var option1 = TextEditingController();
  var option2 = TextEditingController();
  var option3 = TextEditingController();
  var option1Val = TextEditingController();
  var option2Val = TextEditingController();
  var option3Val = TextEditingController();


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {



    return ScrollablePage(

      appBar: HaweyatiAppBar(),
      title: "Add Finishing Material",
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
//          Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//
//
//          SizedBox(height: 30),
//          PickImage(),

          SizedBox(height: 25),

          Text("Pricing",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

          SizedBox(height: 25),


          HaweyatiTextField( label: "Price",keyboardType: TextInputType.phone,),

          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Theme.of(context).primaryColor,
            value: multipleVariants,
            title: Text('This product has multiple variants'),
            onChanged: (bool val){
              setState(() {
                multipleVariants = val;
              });
            },

          ),

         multipleVariants ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Options",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              FlatButton(
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                  child: Text('Add Options'), onPressed:(){

                  CustomNavigator.navigateTo(context, AddVariants());
//                  _showbottomsheet(
//                    optionValue: option1Val,
//                    option: option1
//                  );

                   })
            ],
          ) : SizedBox(),

        SizedBox(height: 25),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              IconButton(icon: Icon( Icons.search,color: Theme.of(context).primaryColor,size:30,),
                  onPressed:(){

                print("Search");
              })
            ],
          ),


        ])),
      ),
    );
  }


}
