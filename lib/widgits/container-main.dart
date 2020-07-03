import 'package:flutter/material.dart';

class ContainerDetailList extends StatefulWidget {
  String imgpath;
  Function ontap;
  String name;
  ContainerDetailList({this.name,this.ontap,this.imgpath});


  @override
  _ContainerDetailListState createState() => _ContainerDetailListState();
}

class _ContainerDetailListState extends State<ContainerDetailList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Material(elevation: 6,borderRadius: BorderRadius.circular(10),
        child: GestureDetector(              onTap: widget.ontap,

          child: Container(

            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ListTile(
                  leading:
                  Image.asset(widget.imgpath)
                  , title: Text(
                widget.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
