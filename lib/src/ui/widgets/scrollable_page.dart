import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/ui/widgets/app-bar.dart';

class ScrollablePage extends StatelessWidget {
  final String title;
  final Widget child;
  final AppBar appBar;
  final String action;
  final Drawer drawer;
  final String subtitle;
  final Function onAction;
  final GlobalKey<ScaffoldState> key;
  final bool showBackgroundImage;
  final bool showButtonBackground;

  ScrollablePage({
    this.key,
    this.title,
    this.child,
    this.action,
    this.appBar,
    this.drawer,
    this.subtitle,
    this.onAction,
    this.showBackgroundImage = false,
    this.showButtonBackground = false
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.white,
      appBar: this.appBar ?? HaweyatiAppBar(),
      drawer: this.drawer,
      body: Container(
        decoration: showBackgroundImage ? BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, 1),
            image: AssetImage("assets/images/pattern.png"),
          )
        ): null,
        child: CustomScrollView(slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: 30, bottom: 10),
            sliver: SliverToBoxAdapter(child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold
              )
            )),
          ),
          SliverToBoxAdapter(child: Text(
            subtitle,
            textAlign: TextAlign.center,
          )),

          SliverPadding(
            padding: const EdgeInsets.only(top: 40),
            sliver: child,
          )
        ]),
      ),

      extendBody: !showButtonBackground,
      bottomNavigationBar: Material(
        elevation: showButtonBackground ? 20 : 0,
        child: Container(
          color: showButtonBackground ? Colors.white : null,
          child: this.action != null ? Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: 45),
              child: FlatButton(
                onPressed: onAction,
                shape: StadiumBorder(),
                textColor: Colors.white,
                child: Text(this.action),
                color: Theme.of(context).accentColor,
              ),
            ),
          ): null,
        ),
      ),
    );
  }
}
