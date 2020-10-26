import 'package:flutter/material.dart';

class HeaderView extends Wrap {
  HeaderView({
    bool extraTopPadding,
    @required String title,
    @required String subtitle
  }): super(children: [
    Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 10),
      child: Center(child: Text(title, textAlign: TextAlign.center, style: TextStyle(
          color: Color(0xFF313F53),
          fontSize: 18,
          fontWeight: FontWeight.bold
      ))),
    ),
    Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Center(
          child: Text(subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600
            ),
          )),
    ),
  ]);
}

class HeaderViewSliver extends SliverToBoxAdapter {
  HeaderViewSliver({
    bool extraTopPadding,
    @required String title,
    @required String subtitle
  }): super(child: HeaderView(
      extraTopPadding: extraTopPadding,
      title: title,
      subtitle: subtitle
  ));
}