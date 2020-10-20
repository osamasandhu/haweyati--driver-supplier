import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/widgits/add-varient-sheet.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/haweyati-text-field.dart';

class Option {
  String name;
  List<String> values;

  Option({this.name, this.values});
}

class AddVariants extends StatefulWidget {
  @override
  _AddVariantsState createState() => _AddVariantsState();
}

class _AddVariantsState extends State<AddVariants> {
  List<Option> _options = [
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FlatButton(
              textColor: Colors.white,
              color: Theme.of(context).accentColor,
              child: Text("Add an option"),
              onPressed: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  builder: (context) => AddVariant()
                );

                if (result != null) _options.add(result);
                matchVariants();
              },
            ),
//            Text('Current options : ${options.length}'),
//            options.isNotEmpty ? Text(options[0].title) : SizedBox(),
//            for(int i=0; i<options.length; i++)
              Column(
                children: <Widget>[
                  for (int i = 0; i < _options.length; i++)
                    Row(children: <Widget>[
                     Expanded(child: HaweyatiTextField(
                       label: _options[i].values[0],
//                       con
                     )),
                      FlatButton(onPressed: () {
                        setState(() {
                          _options[i].values.removeAt(i);
                        });
                      })
                    ]),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(

                    ),
                  ],
                ),
              ]
            ),
        ),
    );
  }

  matchVariants() {
    var length = 1;

    for (final option in this._options) {
      length *= option.values.length;
    }

//    print(length);

    var result = [];
    var currentVal = 0;
    var waitForIncr = 0;

    for (int i = 0; i < _options.length; ++i) {
      currentVal = 0;
      for (int j = 0; j < length; ++j) {
        if (i == 0) {
          result.add(_options[i].values[j % _options[i].values.length]);
        } else {
          if (j != 0 && j % waitForIncr == 0) ++currentVal;

          result[j] += "/${_options[i].values[currentVal % _options[i].values.length]}";
        }
      }

      if (waitForIncr == 0) {
        waitForIncr = _options[i].values.length;
      } else {
        waitForIncr *= _options[i].values.length;
      }
    }

    print(result);
  }
}



