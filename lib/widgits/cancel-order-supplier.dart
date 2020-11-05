import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/simple-form.dart';
import 'package:haweyati_supplier_driver_app/utils/validators.dart';

class CancelOrderSupplier extends StatefulWidget {

  @override
  _CancelOrderSupplierState createState() => _CancelOrderSupplierState();
}

class _CancelOrderSupplierState extends State<CancelOrderSupplier> {

  var reason = TextEditingController();
  var _key = GlobalKey<SimpleFormState>();

  @override
  Widget build(BuildContext context) {
    return LocalizedView(
      builder: (context,lang) =>
      AlertDialog(
          title: Text("Cancel Item",style: TextStyle(
            fontWeight: FontWeight.bold
          ),),
          content: SimpleForm(
            onSubmit: (){
              Navigator.pop(context,reason.text);
            },
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Please input reason for cancellation of this item."),
                SizedBox(height: 10,),
                HaweyatiTextField(
                  icon: Icons.error,
                  label: 'Reason',
                  maxLines: 3,
                  validator: (value) => emptyValidator(value, 'Reason'),
                  controller: reason,
                )
              ],
            ),
          ),

          insetPadding: const EdgeInsets.all(15),
          titlePadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          actionsPadding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
          contentPadding: const EdgeInsets.all(15),

          actions: [

            TextButton(
                // style: widget.confirmButtonStyle,
                child: Text("Submit"),
                onPressed: () => _key.currentState.submit()
            )
          ]
      ),
    );
  }
}
