import 'package:flutter/material.dart';

class LocalizationSelector extends StatelessWidget {
  final Locale selected;
  final Function onChanged;

  LocalizationSelector({
    this.selected,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Locale>(
      isDense: true,
      iconEnabledColor: Colors.white,
      icon: Icon(Icons.language, size: 20),
      underline: Container(),
      dropdownColor: Theme.of(context).primaryColor,

      value: this.selected ?? Locale('ar'),

      items: [
        DropdownMenuItem(
          value: Locale('en'),
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Text('English', style: TextStyle(color: Colors.white, fontSize: 13)),
          ),
        ),

        DropdownMenuItem(
          value: Locale('ar'),
          child: Text('Arabic', style: TextStyle(color: Colors.white, fontSize: 13)),
        )
      ],

      onChanged: this.onChanged,
    );
  }
}


//class LocalizationSelector extends StatefulWidget {
//  final String selected;
//  final Function onChanged;
//
//  LocalizationSelector({
//    this.onChanged
//  });
//
//  @override
//  _LocalizationSelectorState createState() => _LocalizationSelectorState();
//}
//
//class _LocalizationSelectorState extends State<LocalizationSelector> {
//  final _localizations = {
//    "English": "",
//    "Arabic": ""
//  };
//
//  @override
//  Widget build(BuildContext context) {
//    return Container();
//  }
//}
//
//
//class LocalizationSelector extends DropdownButton {
//  LocalizationSelector(): super(
//    underline: SizedBox(),
//    icon: Icon(Icons.language),
//    dropdownColor: Theme.of(context).primaryColor,
//    value: _language,
//    items: _languages.map((String value) {
//      return new DropdownMenuItem<String>(
//        value: value,
//        child: Image.asset('assets/images/$value.png',height: 30 ,width: 80, color:Colors.white,),
//      );
//    }).toList(),
//    onChanged: (language) {
//      final locale = Locale(language == 'English' ? 'en' : 'ar');
//      setState(() => EasyLocalization.of(context).locale = locale);
//    },
//  );
//}