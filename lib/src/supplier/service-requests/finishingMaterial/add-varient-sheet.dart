import 'package:flutter/material.dart';
import 'add-varients.dart';

class AddVariant extends StatefulWidget {
  final bool editMode;

  AddVariant({this.editMode = false});

  @override
  _AddVariantState createState() => _AddVariantState();
}

class _AddVariantState extends State<AddVariant> {
  var _autoValidate = false;

  final _key = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _values = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Form(
        autovalidate: _autoValidate,
        key: _key,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Add Option", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),
                    GestureDetector(
                      child: Text("Cancel",style: TextStyle(color: Theme.of(context).accentColor)),
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _name,
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Option Name',
                  border: OutlineInputBorder()
                ),
                validator: (value) => value.isEmpty ? 'Please provide option title': null,
              ),

              Divider(indent: 10, endIndent: 10),
              TextFormField(
                decoration: InputDecoration(
                  isDense: true,
                  fillColor: Colors.grey.shade200,
                  hintText: 'Separate option values with comma (,)',
                  border: OutlineInputBorder()
                ),
                validator: (value) => value.isEmpty? 'Please provide option values': null,
                controller: _values,
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 40),
                  child: FlatButton(
                    textColor: Colors.white,
                    child: Text('Create'),
                    shape: StadiumBorder(),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      if (!_key.currentState.validate())
                        setState(() => _autoValidate = true);
                      else Navigator.pop(
                        context,
                        Option(
                          name: _name.text,
                          values: _values.text.split(',')
                        )
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
