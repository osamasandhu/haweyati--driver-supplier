import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/options-model.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
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
          Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),


          SizedBox(height: 30),
          PickImage(),

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

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Options",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              FlatButton(
                textColor: Colors.white,
                color: Theme.of(context).accentColor,
                  child: Text('Add Options'), onPressed:(){

                  _showbottomsheet(
                    optionValue: option1Val,
                    option: option1
                  );
                  
                   })
            ],
          ),


          for(var i = 0; i<options.length; i++)
            Column(
              children: <Widget>[
                Text(options[0].title,style: TextStyle(fontWeight: FontWeight.bold),),
                for(var j=0; j<options[i].optionValues.length; j++)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(options[i].optionValues[j].valueName),
                      Expanded(
                        child: HaweyatiTextField(
                         label: 'Price',
                         controller: options[i].optionValues[j].valueController,
                        ),
                      ),
                      FlatButton(
                        shape: CircleBorder(),
                        color: Colors.red,
                        child: Icon(Icons.delete,color: Colors.white,),
                        onPressed: (){
                          setState(() {
                            options[i].optionValues.removeAt(j);
                          });
                        },
                      )
                    ],
                  ),
              ],
            ),


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







  void _showbottomsheet({TextEditingController option,TextEditingController optionValue}) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: true,
        builder: (builder) {

          return Container(margin: EdgeInsets.only(top: 0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(15),
              topLeft: Radius.circular(15),)),
            padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                HaweyatiTextField(label: "Option Name",controller: option1.text.isEmpty ? option1 : (option2.text.isEmpty ? option2 : option3) ,),
                SizedBox(height: 15,),
                HaweyatiTextField(label: "Separate options d comma.",
                  controller: option1Val.text.isEmpty ? option1Val : (option2Val.text.isEmpty ? option2Val : option3Val) ,),
                SizedBox(height: 15,),
                FlatButton(shape: StadiumBorder(), color: Theme.of(context).accentColor,
                    textColor: Colors.white, onPressed: (){
                  List<String> optionValues = [];
                  optionValues = option1Val.text.split(',');
                  setState(() {
                    options.add(
                        Option(
                            title: option1.text,
                          optionValues: [
                            for(var i=0; i<optionValues.length; i++)
                              OptionValue(
                                valueName: optionValues[i],
                                valueController: TextEditingController()
                              )
                          ]
                        )
                    );
                  });
                  print(optionValues.length);
//                  Navigator.pop(context);
                  }, child: Text("Submit"))
              ],
            ),
          );
        });
  }

}
