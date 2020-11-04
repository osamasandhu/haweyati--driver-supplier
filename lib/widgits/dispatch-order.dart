import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/data.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/loading-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:image_picker/image_picker.dart';

class DispatchOrder extends StatefulWidget {
  final String orderId;
  DispatchOrder({this.orderId});
  @override
  _DispatchOrderState createState() => _DispatchOrderState();
}

class _DispatchOrderState extends State<DispatchOrder> {
  var _autoValidate = false;

  final _key = GlobalKey<SimpleFormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _name = TextEditingController();
  final _values = TextEditingController();

  PickedFile image;

  @override
  Widget build(BuildContext context) {
    return ScrollableView(
      key: scaffoldKey,
      padding: EdgeInsets.only(left: 8,right:8,top: 20,bottom: 100),
      appBar: HaweyatiAppBar(),
      child: SimpleForm(
        key: _key,
        onSubmit: () async {
          if(image==null){
            showSimpleSnackbar(scaffoldKey, "Please select an image");
          } else {
            openLoadingDialog(context, "Marking order as dispatched");
            await HaweyatiService.patch("orders/pickup-update", {
              '_id' : widget.orderId,
              'supplierId' : AppData.supplier.id
            });
            await HaweyatiService.patch('orders/add-image', FormData.fromMap({
              'id': widget.orderId,
              'image' :  await MultipartFile.fromFile(image.path),
              'sort' : 'Supplier: ${AppData.supplier.person.name}'
            }));
            Navigator.pop(context);
            openMessageDialog(context, "Order dispatched successfully!",3);
          }
        },

        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom : 15.0),
                child: Text(
                    "Complete Order",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Please attach a photo confirming order completion."),
              ),
              ImagePickerWidget(
                onImagePicked: (PickedFile file){
                  image = file;
                },
              ),

            ],
          ),
        ),
      ),
      bottom: FlatActionButton(label: 'Submit',onPressed: (){
        _key.currentState.submit();
      },icon: Icon(Icons.done),),
    );
  }
}
