import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemCountContainer extends StatefulWidget {
  final String extra;
  final String dayPrice;
  final Function(int) onValueChange;

  ItemCountContainer({
    this.extra,
    this.dayPrice,
    this.onValueChange
  });

  @override
  _ItemCountContainerState createState() => _ItemCountContainerState();
}

class _ItemCountContainerState extends State<ItemCountContainer> {
  int _quantity = 0;

  _increment() {
    setState(() => ++_quantity);
    widget.onValueChange(_quantity);
  }

  _decrement() {
    if(_quantity > 0) {
      setState(() => --_quantity);
      widget.onValueChange(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(color:Color(0xfff2f2f2f2),
        borderRadius: BorderRadius.circular(15),
      ),

      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: <Widget>[

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment:CrossAxisAlignment.start,children: <Widget>[
                Text(
                  widget.extra,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 10,),
                Text(
                  widget.dayPrice,
                  style: TextStyle(
                      fontSize: 16),
                ),],

              ),

              Row(children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: IconButton(padding: EdgeInsets.zero,
                    icon: Icon(Icons.remove,color: Colors.white,),
                    onPressed: _decrement
                  ),
                ),
                Padding(
                  padding: const EdgeInsets
                      .symmetric(
                      horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.white,),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Text(
                        "$_quantity",             style: TextStyle(
                          fontSize: 12,color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(25),
                      color: Theme.of(context).accentColor),
                  child: IconButton(padding: EdgeInsets.zero,
                    icon:
                    Icon(Icons.add,color: Colors.white,),
                    onPressed: _increment,
                  ),
                ),
              ])
            ],mainAxisAlignment: MainAxisAlignment.spaceBetween,)
      ),
    );
  }
}
