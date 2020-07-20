
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/add-varients.dart';

class AddVariant extends StatefulWidget {
  final bool editMode;
  AddVariant({this.editMode=false});

  @override
  _AddVarientState createState() => _AddVarientState();
}

class _AddVarientState extends State<AddVariant> {
  TextEditingController variant = TextEditingController();
  TextEditingController variantValues = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Add Options",style: TextStyle(color: Theme.of(context).accentColor,fontWeight: FontWeight.bold,fontSize: 15),),
                ),
                FlatButton(
                  splashColor: Colors.grey.shade200,
                  child: Text("Cancel",style: TextStyle(color: Theme.of(context).accentColor),),
                  onPressed: ()=> Navigator.pop(context),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Option Name',
                  border: OutlineInputBorder()
              ),
              validator: (value) {
                if(value.isEmpty){
                  return 'Please provide option title';
                }
                return null;
              },
              controller: variant,
            ),
          ),

          Divider(indent: 10, endIndent: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Separate option values with comma (,)',
                  border: OutlineInputBorder()
              ),
              validator: (value) {
                if(value.isEmpty){
                  return 'Please provide option values';
                }
                return null;
              },
              controller: variantValues,
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(12, 30, 12, 8),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: 40),
              child: FlatButton(
                textColor: Colors.white,
                child: Text('Create'),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.pop(
                    context,
                    Option()
                      ..name = variant.text
                      ..values = variantValues.text.split(',')
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
