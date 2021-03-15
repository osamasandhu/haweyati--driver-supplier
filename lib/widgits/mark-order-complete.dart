import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/models/order/order_model.dart';
import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/flat-action-button.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/image-picker-widget.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/message-dialog.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/scroll_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/utils/lazy_task.dart';
import 'package:haweyati_supplier_driver_app/utils/simple-snackbar.dart';
import 'package:image_picker/image_picker.dart';
class MarkOrderCompleted extends StatefulWidget {
  final String orderId;
  MarkOrderCompleted({this.orderId});
  @override
  _MarkOrderCompletedState createState() => _MarkOrderCompletedState();
}

class _MarkOrderCompletedState extends State<MarkOrderCompleted> {

  final _key = GlobalKey<SimpleFormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
            await performLazyTask(context, () async {
              await HaweyatiService.patch("orders/update-order-status", {
                '_id' : widget.orderId,
                'status' : OrderStatus.delivered.index
              });
              await HaweyatiService.patch('orders/add-image', FormData.fromMap({
                'id': widget.orderId,
                'image' :  await MultipartFile.fromFile(image.path),
                'sort' : 'driver'
              }));
            },message: 'Marking order as completed');
            openMessageDialog(context, "Order completed successfully!",3);
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
