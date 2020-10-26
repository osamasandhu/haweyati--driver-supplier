import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/l10n/app_localizations.dart';
import 'package:haweyati_supplier_driver_app/src/ui/views/dotted-background_view.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/no-scroll_page.dart';
import 'package:haweyati_supplier_driver_app/utils/exit-application-dialog.dart';

class PreSignInPage extends StatefulWidget {
  @override
  _PreSignInPageState createState() => _PreSignInPageState();
}

class _PreSignInPageState extends State<PreSignInPage> {
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () => exitApp(context),
      child: NoScrollPage(
            body: DottedBackgroundView(
              child: Column(children: <Widget>[
                Expanded(
                  flex: 10,
                  child: Center(child: Image.asset("assets/images/icon.png", height: 200))
                ),
                Spacer(flex: 2),

                _buildButton(
                  color: Theme.of(context).accentColor,
                  name: AppLocalizations.of(context).signInAsDriver,
                  onTap: () => Navigator.of(context).pushNamed('/driver-sign-in'),
                ),
                SizedBox(height: 20),
                _buildButton(
                  color: Theme.of(context).primaryColor,
                  name: AppLocalizations.of(context).signInAsSupplier,
                  onTap: () => Navigator.of(context).pushNamed('/supplier-sign-in'),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  child: Text("REGISTER NOW", style: TextStyle(color: Colors.grey)),
                  onTap: () =>  Navigator.of(context).pushNamed('/pre-sign-up')
                ),
                SizedBox(height: 20)
              ]),
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
