import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RichPriceText extends StatelessWidget {
  final Color color;
  final double price;
  final double fontSize;
  final FontWeight fontWeight;

  RichPriceText({
    this.price,
    this.color = const Color(0xFF313F53),
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal
  });

  @override
  Widget build(BuildContext context) {
    final _str = price.toStringAsFixed(2).split('.');
    final frac = _str.last;
    final main = _str.first;

    return RichText(
      textAlign: TextAlign.right,
      text: TextSpan(
        text: '$main.',
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: 'Lato',
          fontWeight: fontWeight,
        ),

        children: [
          TextSpan(
            text: '$frac SAR',
            style: TextStyle(
              color: color,
              fontFamily: 'Lato',
              fontSize: fontSize - 2,
              fontWeight: fontWeight,
            )
          )
        ]
      ),
    );
  }
}
