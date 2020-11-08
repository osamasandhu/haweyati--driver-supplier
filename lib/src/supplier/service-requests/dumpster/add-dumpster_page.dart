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


class DumpsterRequestPage extends StatefulWidget {
  @override
  _DumpsterRequestPageState createState() => _DumpsterRequestPageState();
}

class _DumpsterRequestPageState extends State<DumpsterRequestPage> {
  var _key = GlobalKey<SimpleFormState>();

  final _day = TextEditingController();
  final _size = TextEditingController();
  final _rent = TextEditingController();
  final _extraDay = TextEditingController();
  final _helperPrice = TextEditingController();
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
    return LocalizedView(
      builder: (context,lang)=>
      SimpleForm(
          key: _key,
          onSubmit: () async {
           if (_file == null) {
             showSimpleSnackbar(scaffoldKey, lang.noImageSelected,true);
             return null;
           } else if (_city == null || _city.isEmpty) {
             showSimpleSnackbar(scaffoldKey, lang.noLocationPicked,true);
             return null;
           }

           openLoadingDialog(context, lang.submittingRequest);
            FormData data = FormData.fromMap({
              'suppliers': AppData.supplier.id,
              'type': 'Construction Dumpster',
              'size' : int.parse(_size.text),
              'description' : _description.text,
              'city' : _city,
              'days' : _day.text,
              'rent' : _rent.text,
              'helperPrice' : _helperPrice.text,
              'extraDayRent' : _extraDay.text,
              'note' : _note.text
            });

            data.files.add(MapEntry(
              'image', await MultipartFile.fromFile(_file.path)
            ));

            var response =  await HaweyatiService.post('service-requests', data);
            Navigator.pop(context);

            openMessageDialog(context, "${lang.submittingRequest} ${response.data['requestNo']}",2);
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
                    lang.addDumpster,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              HaweyatiTextField(label: lang.size, controller: _size, keyboardType: TextInputType.number,
              validator: (value)=> emptyValidator(value, lang.size),),
              SizedBox(height: 10),
              HaweyatiTextField(maxLength: null, label: lang.description, controller: _description,
              validator: (value)=> emptyValidator(value, lang.description),),
              SizedBox(height: 15),
              Text(lang.pricing, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              LocationPickerWidget(onChanged: (locationData) {
                print("Printing city");
                print(locationData.city);
                _city = locationData.city;
              }),
              SizedBox(height: 15),

              Row(children: <Widget>[
                Expanded(child: HaweyatiTextField(label: lang.helperPrice, controller: _helperPrice, keyboardType: TextInputType.number,
                validator: (value)=> emptyValidator(value, lang.helperPrice),
                )),
                SizedBox(width: 10),
                Expanded(child: HaweyatiTextField(label: lang.days, controller: _day, keyboardType: TextInputType.number,
                  validator: (value)=> emptyValidator(value, lang.helperPrice),
                ))
              ]),
              SizedBox(height: 10),
              Row(children: <Widget>[
                Expanded(child: HaweyatiTextField(label: lang.rent, controller: _rent, keyboardType: TextInputType.number,
                  validator: (value)=> emptyValidator(value, lang.helperPrice),
                )),
                SizedBox(width: 10),
                Expanded(child: HaweyatiTextField(label: lang.extraDayRent, controller: _extraDay, keyboardType: TextInputType.number,
                  validator: (value)=> emptyValidator(value, lang.helperPrice),
                ))
              ]),

              SizedBox(height: 25),

              ImagePickerWidget(
                onImagePicked: (PickedFile image){
                  _file = image;
                },
              ),
              SizedBox(height: 10),
              HaweyatiTextField(maxLength: null, label: lang.note, controller: _note),
            ],
            // child: SliverPadding(padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
            //   sliver: SliverList(delegate: SliverChildListDelegate([
            //
            //
            //
            //   ])),
            // ),
          ),
      ),
    );
  }
}
