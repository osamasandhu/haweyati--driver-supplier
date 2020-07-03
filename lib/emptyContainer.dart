import 'package:flutter/material.dart';

class EmptyContainer extends StatefulWidget {
  Widget child;
  EmptyContainer({this.child});
  @override
  _EmptyContainerState createState() => _EmptyContainerState();
}

class _EmptyContainerState extends State<EmptyContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),    decoration: BoxDecoration(color:Color(0xfff2f2f2f2),
      borderRadius: BorderRadius.circular(15),
    ), width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),child: widget.child,
    );
  }
}
