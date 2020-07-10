
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
import 'package:haweyati_supplier_driver_app/widgits/haweyati_Textfield.dart';
import 'package:haweyati_supplier_driver_app/widgits/image.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';


class AddBuildingMaterial extends StatefulWidget {
  @override
  _AddBuildingMaterialState createState() => _AddBuildingMaterialState();
}

class _AddBuildingMaterialState extends State<AddBuildingMaterial> {




  @override
  Widget build(BuildContext context) {



    return ScrollablePage(

      appBar: HaweyatiAppBar(),
      title: "Add Building Materail",
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
            ,Expanded(child: HaweyatiTextField( label: "Price",keyboardType: TextInputType.phone,))

          ],mainAxisAlignment: MainAxisAlignment.spaceBetween,),
          SizedBox(height: 25),

          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Media",
                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),IconButton(icon: Icon( Icons.search,color: Theme.of(context).primaryColor,size:30,),
                  onPressed:(){

                print("Search");
              })
            ],
          ),

        ])),
      ),
    );
  }












//
//  void _showbottomsheet() {
//    showModalBottomSheet(
//        backgroundColor: Colors.transparent,
//        context: context,
//        builder: (builder) {
//          return Padding(
//            padding:  EdgeInsets.all(15.0),
//            child: Padding(
//              padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/4.2),
//              child: Column(
//                children: <Widget>[
//                  ButtonTheme(
//                      minWidth: MediaQuery.of(context).size.width,
//                      height: 58.0,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(10),
//                              topRight: Radius.circular(10)),
//                        ),
//                        color: Colors.white,
//                        child: Text(
//                          "New Job",
//                          style: TextStyle(color: Colors.blue, fontSize: 18),
//                        ),
//                        onPressed: () {
////                          Navigator.push(
////                              context,
////                              MaterialPageRoute(
////                                  builder: (context) => NewJob()));
//                        },
//                      )),
//
//                  SizedBox(
//                    height: 0.8,
//                  ),
////2nd button
//
//                  ButtonTheme(
//                      minWidth: MediaQuery.of(context).size.width,
//                      height: 58.0,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.only(
//                              bottomRight: Radius.circular(10),
//                              bottomLeft: Radius.circular(10)),
//                        ),
//                        color: Colors.white,
//                        child: Text(
//                          "New Invoice",
//                          style: TextStyle(color: Colors.blue, fontSize: 18),
//                        ),
//                        onPressed: () {
////                          Navigator.push(
////                              context,
////                              MaterialPageRoute(
////                                  builder: (context) => NewInvoice()));
//                        },
//                      )),
//
//                  SizedBox(
//                    height: 0.8,
//                  ),
////3rd button
//
//                  SizedBox(
//                    height: 15,
//                  ),
//
//                  ButtonTheme(
//                      minWidth: MediaQuery.of(context).size.width,
//                      height: 58.0,
//                      child: RaisedButton(
//                        shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(10)),
//                        color: Colors.white,
//                        child: Text(
//                          "Cancel",
//                          style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              color: Colors.blue,
//                              fontSize: 18),
//                        ),
//                        onPressed: () {
//                          Navigator.of(context).pop();
//                        },
//                      ))
//                ],
//              ),
//            ),
//          );
//        });
//  }





}
