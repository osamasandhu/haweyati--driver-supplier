import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.time,  this.isMe,this.isFirstSender,this.isFirstReceiver});
  final String message, time;
  final isMe;
  final isFirstSender;
  final isFirstReceiver;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMe ? Colors.grey.shade200 : Color(0xff313f53);
    final msgTxtColor = isMe ? Colors.black : Colors.white;
    final align = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final radius = isMe
        ? (isFirstSender ? BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0)
     ) : BorderRadius.only(
        topLeft: Radius.circular(10.0),
        bottomLeft: Radius.circular(10.0),
    )) : (isFirstReceiver ? BorderRadius.only(
      topRight: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
      topLeft: Radius.circular(10.0),
    ) : BorderRadius.only(
      topLeft: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
    ));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal :8.0),
      child: Column(
        crossAxisAlignment: align,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
//              gradient: isMe ? LinearGradient(
//                begin: Alignment.centerLeft,
//                end: Alignment.centerRight,
//                colors: [Color(0XFFb30a0a),Color(0XFFcd0606),Color(0XFFe70101),Color(0XFFed0101)],
//              ) : LinearGradient(
//                begin: Alignment.centerLeft,
//                end: Alignment.centerRight,
//                colors: [Colors.grey.shade400,Colors.grey.shade300,Colors.grey.shade200],
//              ),
              color: bubbleColor,
              borderRadius: radius,
            ),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 48.0),
                  child: Text(message,style: TextStyle(color: msgTxtColor),),
                ),
                Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Row(
                    children: <Widget>[
                      Text(time,
                          style: TextStyle(
                            color: msgTxtColor,
                            fontSize: 10.0,
                          )),
                      SizedBox(width: 3.0),

                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}