import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/localized_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/localization-selector.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/no-scroll_page.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';
import 'package:haweyati_supplier_driver_app/widgits/localization-selector.dart';

class PreSignInPage extends StatefulWidget {
  @override
  _PreSignInPageState createState() => _PreSignInPageState();
}

class _PreSignInPageState extends State<PreSignInPage> {
  @override
  Widget build(BuildContext context) {
    return  LocalizedView(
        builder: (context, lang) => WillPopScope(
        onWillPop: () => exitApp(context),
        child: NoScrollPage(
              body: DottedBackgroundView(
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    // backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: LocalizationSelector(),
                      )
                    ],
                  ),
                  body: Column(children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Center(child: Image.asset("assets/images/icon.png", height: 200))
                    ),
                    Spacer(flex: 2),

                    _buildButton(
                      color: Theme.of(context).accentColor,
                      name:   lang.signInAsDriver,
                      onTap: () => Navigator.of(context).pushNamed('/driver-sign-in'),
                    ),
                    SizedBox(height: 20),
                    _buildButton(
                      color: Theme.of(context).primaryColor,
                      name: lang.signInAsSupplier,
                      onTap: () => Navigator.of(context).pushNamed('/supplier-sign-in'),
                    ),
                    SizedBox(height: 40),
                    GestureDetector(
                      child: Text(lang.registerNow, style: TextStyle(color: Colors.grey)),
                      onTap: () =>  Navigator.of(context).pushNamed('/pre-sign-up')
                    ),
                    SizedBox(height: 20)
                  ]),
                ),
              ),
        ),
      ),
    );
  }

  Widget _buildButton({String name, Function onTap, Color color}) {
    return SizedBox(
      width: 300,
      height: 55,
      child: FlatButton(
        child: Text(name.toUpperCase()),
        shape: StadiumBorder(),
        color: color,
        textColor: Colors.white,
        onPressed: onTap
      ),
    );
  }
}
