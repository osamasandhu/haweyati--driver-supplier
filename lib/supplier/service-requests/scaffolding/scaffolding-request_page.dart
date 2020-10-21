import 'package:dio/dio.dart';
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

class ScaffoldingRequest extends StatefulWidget {
  @override
  _BuildingMaterialRequestState createState() => _BuildingMaterialRequestState();
}

class _BuildingMaterialRequestState extends State<ScaffoldingRequest> {
  var _key = GlobalKey<SimpleFormState>();

  final _description = TextEditingController();
  final _note = TextEditingController();
  final _rent = TextEditingController();
  final _days = TextEditingController();
  final _extraDaysRent = TextEditingController();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  String _city;

  @override
  Widget build(BuildContext context) {
    return SimpleForm(
      key: _key,
      onSubmit: () async {
        if (_city == null || _city.isEmpty) {
          showSimpleSnackbar(scaffoldKey, "No location picked",true);
          return null;
        }

        openLoadingDialog(context, "Submitting Request");
        FormData data = FormData.fromMap({
          'suppliers': AppData.supplier.sId,
          'type': 'Scaffolding',
          'description' : _description.text,
          'city' : _city,
          'rent' : _rent.text,
          'days' : _days.text,
          'extraDaysRent' : _extraDaysRent.text,
          'note' : _note.text
        });

        var response =  await HaweyatiService.post('service-requests', data);
        Navigator.pop(context);

        openMessageDialog(context, "Request submitted successfully! Request No : ${response.data['requestNo']}",true);
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
                "Scaffolding Request",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
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
            Expanded(child: HaweyatiTextField(label: 'Rent', controller: _rent, keyboardType: TextInputType.number,
              validator: (value)=> emptyValidator(value, 'Rent'),
            )),
            SizedBox(width: 10),
            Expanded(child: HaweyatiTextField(label: 'Days', controller: _days, keyboardType: TextInputType.number,
              validator: (value)=> emptyValidator(value, 'Days'),
            ))
          ]),
          SizedBox(height: 15),
          HaweyatiTextField(maxLength: null, label: 'Extra Day Rent', controller: _extraDaysRent,
            keyboardType: TextInputType.number,
            validator: (value)=> emptyValidator(value, 'Extra Day Rent'),),
          SizedBox(height: 15),

          SizedBox(height: 25),

          HaweyatiTextField(maxLength: null, label: 'Note', controller: _note),
        ],
      ),
    );
  }
}
