import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add-varient-sheet.dart';

class Option{
  String name;
  List<String> values;

  Option({this.name, this.values});
}

class AddVariants extends StatefulWidget {
  @override
  _AddVariantsState createState() => _AddVariantsState();
}

class _AddVariantsState extends State<AddVariants> {
  List optionsResult = [];
  List<Option> _options = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Completed")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Variants", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),

            for (final option in _options)
              ExpansionTile(
                title: Text(option.name),
                children: <Widget>[
                  for (final item in option.values)
                    ListTile(
                      dense: true,
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          option.values.remove(item);
                          if (option.values.length == 0) {
                            _options.remove(option);
                          }
                          this.matchVariants();
                          setState(() {});
                        }
                      )
                    )
                ],
              ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Variant Prices", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              )),
            ),

            _options.isNotEmpty ? Container(
             width: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(8),
                 child: Table(
                   columnWidths: {
                     (_options.length): FlexColumnWidth(_options.length.toDouble())
                   },
                   children: <TableRow>[
                     TableRow(children: [
                       for (final option in _options)
                         Container(
                           padding: const EdgeInsets.all(8),
                           color: Theme.of(context).primaryColor,
                           child: Text(option.name.toUpperCase(), style: TextStyle(
                             color: Colors.white
                           ))
                         ),

                       Container(
                         padding: const EdgeInsets.symmetric(vertical: 8),
                         color: Theme.of(context).primaryColor,
                         child: Text('Price', style: TextStyle(
                           color: Colors.white
                         ))
                       ),
                     ]),

                     for (final option in optionsResult)
                       TableRow(
                         children: [
                           for (final name in option.split('/'))
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Text(name.trim()),
                             ),

                           Padding(
                             padding: const EdgeInsets.symmetric(vertical: 2),
                             child: CupertinoTextField(keyboardType: TextInputType.number),
                           )
                         ]
                       )
                   ],
                 ),
               ),
             ),
            ): SizedBox(),
          ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await showModalBottomSheet(
              isScrollControlled: true,
            context: context, builder: (context) => AddVariant(),
          );

          if (result != null) {
            _options.add(result);
            setState(matchVariants);
          };
        }
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
    optionsResult = result;

    print(result);
  }
}



