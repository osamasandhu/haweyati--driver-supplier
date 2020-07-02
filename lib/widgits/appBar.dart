import 'package:flutter/material.dart';

class HaweyatiAppBar extends AppBar {
  bool showFilter;
  bool showadd;


  HaweyatiAppBar(
      {BuildContext context,
      double progress = 0.0,
this.showFilter =false
,this.showadd =false
      })
      : super(
            brightness: Brightness.dark,
            elevation: 0,
            iconTheme: new IconThemeData(color: Colors.white),
            centerTitle: true,
            backgroundColor: Color(0xff313f53),
            title: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                "assets/images/icon.png",
                width: 40,
                height: 40,
              ),
            ),
            actions: [
              showFilter
                  ? Padding(
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(width: 45,
                      child: IconButton(
                          icon: Image.asset("assets/images/cart.png"),
                          onPressed: () {
                          },
                        ),
                    ),
                  )
                  : Container()
            ,  showadd
                  ? Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(width: 45,
                  child: IconButton(
                    icon: Icon(Icons.add,size: 35,),
                    onPressed: () {
                    },
                  ),
                ),
              )
                  : Container()
            ],
);
}
