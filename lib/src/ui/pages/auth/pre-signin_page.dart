import 'package:flutter/material.dart';

class PreSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Center(child: Image.asset("assets/images/icon.png", height: 200))
            ),

            Spacer(flex: 2),

            _buildButton(
              onTap: () => Navigator.of(context).pushNamed('/sign-in'),
              btnName: "SIGN IN AS DRIVER",
              color: Theme.of(context).accentColor
            ),

            SizedBox(height: 20),

            _buildButton(
              onTap: () => Navigator.of(context).pushNamed('/sign-in'),
              btnName: "SIGN IN AS SUPPLIER ",
              color: Theme.of(context).primaryColor
            ),

            SizedBox(height: 40),

            GestureDetector(
              child: Text("REGISTER NOW", style: TextStyle(color: Colors.grey)),
              onTap: () => Navigator.of(context).pushNamed('/pre-sign-up')
            ),

            SizedBox(height: 20)
          ],
        ),
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
