import 'package:dio/dio.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
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
    return LocalizedView(
      builder: (context,lang) =>
      SimpleForm(
        key: _key,
        onSubmit: () async {
          if (_city == null || _city.isEmpty) {
            showSimpleSnackbar(scaffoldKey, lang.noLocationPicked,true);
            return null;
          }

          openLoadingDialog(context, lang.submittingRequest);
          FormData data = FormData.fromMap({
            'suppliers': AppData.supplier.id,
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
                  lang.scaffoldingRequest,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            HaweyatiTextField(maxLength: null, label: lang.description, controller: _description,
              validator: (value)=> emptyValidator(value, lang.description),),
            SizedBox(height: 15),
            Text(lang.pricing, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            LocationPickerWidget(onChanged: (locationData) {
              _city = locationData.city;
            }),
            SizedBox(height: 15),
            Row(children: <Widget>[
              Expanded(child: HaweyatiTextField(label: lang.rent, controller: _rent, keyboardType: TextInputType.number,
                validator: (value)=> emptyValidator(value, lang.rent),
              )),
              SizedBox(width: 10),
              Expanded(child: HaweyatiTextField(label: lang.days, controller: _days, keyboardType: TextInputType.number,
                validator: (value)=> emptyValidator(value, lang.days),
              ))
            ]),
            SizedBox(height: 15),
            HaweyatiTextField(maxLength: null, label: lang.extraDayRent, controller: _extraDaysRent,
              keyboardType: TextInputType.number,
              validator: (value)=> emptyValidator(value, lang.extraDayRent),),
            SizedBox(height: 15),

            SizedBox(height: 25),

            HaweyatiTextField(maxLength: null, label: lang.note, controller: _note),
          ],
        ),
      ),
    );
  }
}
