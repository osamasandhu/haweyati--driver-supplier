import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/driver-signup_page.dart';
import 'package:haweyati_supplier_driver_app/src/ui/pages/auth/supplier-signup_page.dart';

class PreSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 10,
            child: Center(child: Image.asset("assets/images/icon.png", height: 200))
          ),
          Spacer(flex: 2),
          _buildButton(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DriverSignUpPage()));
            },
            btnName: "SIGNUP AS DRIVER",
            color: Theme.of(context).accentColor
          ),

          SizedBox(height: 20),

          _buildButton(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SupplierSignUpPage()));
            },
            btnName: "SIGNUP AS SUPPLIER ",
            color: Theme.of(context).primaryColor
          ),

          SizedBox(height: 40),

          GestureDetector(
            child: Text("LOGIN NOW", style: TextStyle(color: Colors.grey)),
            onTap: () => Navigator.of(context).pop()
          ),

          SizedBox(height: 20)
        ],
      ),
    );
  }

  Widget _buildButton({String btnName, Function onTap, Color color}) {
    return SizedBox(
      width: 300,
      height: 55,
      child: FlatButton(
        child: Text(btnName),
        shape: StadiumBorder(),
        color: color,
        textColor: Colors.white,
        onPressed: onTap
      ),
    );
  }
}
