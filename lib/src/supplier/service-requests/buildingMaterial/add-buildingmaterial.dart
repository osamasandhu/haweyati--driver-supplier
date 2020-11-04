import 'package:dio/dio.dart';
import 'package:haweyati_supplier_driver_app/model/building-material-model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
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
import 'package:haweyati_supplier_driver_app/src/ui/widgets/location-picker-widget.dart';

class BuildingMaterialRequest extends StatefulWidget {
  final BuildingMaterialModel category;
  BuildingMaterialRequest({this.category});
  @override
  _BuildingMaterialRequestState createState() => _BuildingMaterialRequestState();
}

class _BuildingMaterialRequestState extends State<BuildingMaterialRequest> {
  var _key = GlobalKey<SimpleFormState>();

  final _title = TextEditingController();
  final _price12Yard = TextEditingController();
  final _price24Yard = TextEditingController();
  final _description = TextEditingController();
  final _note = TextEditingController();
  String shopParentId;

  var scaffoldKey = GlobalKey<ScaffoldState>();

  String _city;
  PickedFile _file;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleForm(
      key: _key,
      onSubmit: () async {
        if (_file == null) {
          showSimpleSnackbar(scaffoldKey, "No image picked",true);
          return null;
        } else if (_city == null || _city.isEmpty) {
          showSimpleSnackbar(scaffoldKey, "No location picked",true);
          return null;
        }

        openLoadingDialog(context, "Submitting Request");
        FormData data = FormData.fromMap({
          'parent' : widget.category.sId,
          'parentName' : widget.category.name,
          'suppliers': AppData.supplier.id,
          'type': 'Building Material',
          'title' : _title.text,
          'description' : _description.text,
          'city' : _city,
          'price12Yard' : _price12Yard.text,
          'price24Yard' : _price24Yard.text,
          'note' : _note.text
        });

        data.files.add(MapEntry(
            'image', await MultipartFile.fromFile(_file.path)
        ));

        var response =  await HaweyatiService.post('service-requests', data);
        Navigator.pop(context);

        openMessageDialog(context, "Request submitted successfully! Request No : ${response.data['requestNo']}",2);
      },
      child: ScrollableView(
        key: scaffoldKey,
        padding: EdgeInsets.only(left: 8,right:8,top: 20,bottom: 100),
        bottom: RaisedActionButton(
          label: 'Submit',
          onPressed: (){
            _key.currentState.submit();
          },
        ),
        appBar: HaweyatiAppBar(),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom : 15.0),
            child: Text(
                "Add Building Material",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          HaweyatiTextField(label: "Title", controller: _title,
            validator: (value)=> emptyValidator(value, 'Title'),),
          SizedBox(height: 10),
          HaweyatiTextField(maxLength: null, label: 'Description', controller: _description,
            validator: (value)=> emptyValidator(value, 'Description'),),
          SizedBox(height: 15),
          Text('Pricing', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          LocationPickerWidget(onChanged: (locationData) {
            _city = locationData.city;
          }),
          SizedBox(height: 15),
          Row(children: <Widget>[
            Expanded(child: HaweyatiTextField(label: '12 Yard Price', controller: _price12Yard, keyboardType: TextInputType.number,
              validator: (value)=> emptyValidator(value, '12 Yard Price'),
            )),
            SizedBox(width: 10),
            Expanded(child: HaweyatiTextField(label: '24 Yard Price', controller: _price24Yard, keyboardType: TextInputType.number,
              validator: (value)=> emptyValidator(value, '24 Yard Price'),
            ))
          ]),

          SizedBox(height: 25),

          ImagePickerWidget(
            onImagePicked: (PickedFile image){
              _file = image;
            },
          ),
          SizedBox(height: 10),
          HaweyatiTextField(maxLength: null, label: 'Note', controller: _note),
        ],
      ),
    );
  }
}
