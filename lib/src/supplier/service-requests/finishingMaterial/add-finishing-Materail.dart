import 'package:dio/dio.dart';
import 'package:haweyati_supplier_driver_app/model/models/finishing-material_category.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/raised-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'add-varients.dart';


class FinishingMaterialRequest extends StatefulWidget {
  final FinishingMaterialCategory parent;
  FinishingMaterialRequest({this.parent});
  @override
  _FinishingMaterialRequestState createState() => _FinishingMaterialRequestState();
}

class _FinishingMaterialRequestState extends State<FinishingMaterialRequest> {
  var _key = GlobalKey<SimpleFormState>();

  final _day = TextEditingController();
  final _title = TextEditingController();
  final _price = TextEditingController();
  final _description = TextEditingController();
  final _note = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool multipleVariants = false;

  PickedFile _file;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
       SimpleForm(
        key: _key,
        onSubmit: () async {
          if (_file == null) {
            showSimpleSnackbar(scaffoldKey, lang.noImageSelected,true);
            return null;
          }

          openLoadingDialog(context, lang.submittingRequest);
          FormData data = FormData.fromMap({
            'parentId' : widget.parent.sId,
            'parent' : widget.parent.name,
            'suppliers': AppData.supplier.id,
            'title': _title.text,
            'type': 'Finishing Material',
            'price' : _price.text,
            'description' : _description.text,
            'note' : _note.text
          });

          data.files.add(MapEntry(
              'image', await MultipartFile.fromFile(_file.path)
          ));

          var response =  await HaweyatiService.post('service-requests', data);
          Navigator.pop(context);

          openMessageDialog(context, "${lang.requestSubmitted} ${response.data['requestNo']}",2);
        },
        child: ScrollableView(
          key: scaffoldKey,
          padding: EdgeInsets.only(left: 8,right:8,top: 20,bottom: 100),
          bottom: RaisedActionButton(
            label: lang.submit,
            onPressed: (){
              _key.currentState.submit();
            },
          ),
          appBar: HaweyatiAppBar(),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom : 15.0),
              child: Text(
                  lang.addFinishingMaterial,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            HaweyatiTextField(label: lang.name, controller: _title,
              validator: (value)=> emptyValidator(value, lang.name),),
            SizedBox(height: 10),
            HaweyatiTextField(maxLength: null, label: lang.description, controller: _description,
              validator: (value)=> emptyValidator(value, lang.description),),
            SizedBox(height: 15),
            Text(lang.pricing, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Theme.of(context).accentColor,
              value: multipleVariants,
              title: Text(lang.multipleVariantCheck),
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

                     })
              ],
            ) : SizedBox(),
            SizedBox(height: 15),

           !multipleVariants ? Column(
              children: [
                HaweyatiTextField(label: lang.price, controller: _price, keyboardType: TextInputType.number,
                    validator: (value)=> emptyValidator(value, lang.price)),

                SizedBox(height: 25),
              ],
            ) : SizedBox(),


            ImagePickerWidget(
              onImagePicked: (PickedFile image){
                _file = image;
              },
            ),
            SizedBox(height: 10),
            HaweyatiTextField(maxLength: null, label: lang.note, controller: _note),
          ],

        ),
      ),
    );
  }
}



// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/add-varient-sheet.dart';
// import 'package:haweyati_supplier_driver_app/bottomNAvSupplier/finishingMaterial/add-varients.dart';
// import 'package:haweyati_supplier_driver_app/src/const.dart';
// import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';
// import 'package:haweyati_supplier_driver_app/src/ui/widgets/custom-navigator.dart';
// import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
// import 'package:haweyati_supplier_driver_app/widgits/image.dart';
// import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';
//
//
// class AddFinishingMaterial extends StatefulWidget {
//   @override
//   _AddFinishingMaterialState createState() => _AddFinishingMaterialState();
// }
//
// class _AddFinishingMaterialState extends State<AddFinishingMaterial> {
//   bool multipleVariants = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ScrollablePage(
//       appBar: HaweyatiAppBar(),
//       title: "Add Finishing Material",
//       subtitle: loremIpsum.substring(0,35),
//       showButtonBackground: true,
//       action: "Submit",onAction: (){Navigator.of(context).pop();},
//       child: SliverPadding(padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
//         sliver : SliverList( delegate: SliverChildListDelegate( [
//
//           HaweyatiTextField(label: "Size",keyboardType: TextInputType.phone,),
//           SizedBox(height: 15,),
//           TextFormField(
//               scrollPadding: EdgeInsets.only(bottom: 150),
//               maxLength: 180,
//               maxLength: 5,
//               decoration: InputDecoration(
//                   labelText: "Description",
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(width: 2)))
//           ),
// //          Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
// //
// //
// //          SizedBox(height: 30),
// //          PickImage(),
//
//           SizedBox(height: 25),
//
//           Text("Pricing",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//
//           SizedBox(height: 25),
//
//
//           HaweyatiTextField( label: "Price",keyboardType: TextInputType.phone,),
//
//           CheckboxListTile(
//             controlAffinity: ListTileControlAffinity.leading,
//             checkColor: Theme.of(context).primaryColor,
//             value: multipleVariants,
//             title: Text('This product has multiple variants'),
//             onChanged: (bool val){
//               setState(() {
//                 multipleVariants = val;
//               });
//             },
//
//           ),
//
//          multipleVariants ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Options",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//               FlatButton(
//                 textColor: Colors.white,
//                 color: Theme.of(context).accentColor,
//                   child: Text('Add Options'), onPressed:(){
//
//                   CustomNavigator.navigateTo(context, AddVariants());
// //                  _showbottomsheet(
// //                    optionValue: option1Val,
// //                    option: option1
// //                  );
//
//                    })
//             ],
//           ) : SizedBox(),
//
//         SizedBox(height: 25),
//
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text("Media",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
//               IconButton(icon: Icon( Icons.search,color: Theme.of(context).primaryColor,size:30,),
//                   onPressed:(){
//
//                 print("Search");
//               })
//             ],
//           ),
//
//
//         ])),
//       ),
//     );
//   }
//
//
// }
