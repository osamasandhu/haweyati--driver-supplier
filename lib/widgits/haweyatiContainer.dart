import 'package:flutter/material.dart';


class HaweyatiContainer extends StatelessWidget {

  Function onTap;
  String imgPath;
  String title;Color color;
  HaweyatiContainer({this.title,this.onTap,this.imgPath,this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
               margin: EdgeInsets.only(bottom: 15),
        height: 120,
        decoration: new BoxDecoration(color:color,
            image: new DecorationImage(
              image: new AssetImage(imgPath),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
//      ),
    );
  }
}


