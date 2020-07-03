import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/bottomPAges/chat/bottomHomeDetail/bottomHomeDetail.dart';
import 'package:haweyati_supplier_driver_app/widgits/appBar.dart';

import 'order.dart';


class SelectedOrders extends StatelessWidget {

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return




      Scaffold(
appBar: HaweyatiAppBar(),
        body: CustomScrollView(
          controller: scrollController,            slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          ),
          SliverList(delegate: SliverChildBuilderDelegate(
                  (context, i) => GestureDetector(
                onTap: () {
//                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewAllSelectedOrders()));
                },

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 1,
                              color: Colors.grey.shade200
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                              Text("M-3917", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18
                              )),
                              SizedBox(width: 10),
                              Text("15 min ago", style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12,
                                  color: Colors.grey
                              )),
                            ]),

                            SizedBox(height: 20),

                            CupertinoTextField(readOnly: true,
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              suffix: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(Icons.map),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              style: TextStyle(color: Colors.grey.shade600),
                              controller: TextEditingController(text: "address a ksnlsanf samf ljjl j ckl askl salkf akl fkla fkl sdasd as das d asd as da sd as das d as dasd as d asd "),
                            ),

                            SizedBox(height: 15),

                            _buildRow(name1: "Construction Dumpster" ,name2: "12 Yard Dumpster "),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                        ),
                      )
                  ),
                ),
              ),
              childCount: 10
          ),
          ),
        ],
        ),
      );


  }


  Widget _builRow({String name1, String name2}) {
    return Row(
      children: <Widget>[

        Text("$name1 :",style: TextStyle(fontWeight: FontWeight.w700),),
        SizedBox(width: 10,),
        Expanded(child: Text(name2)),
      ],
    );


  }

  Widget _buildRow({String name1, String name2}) {
    return Row(
      children: <Widget>[

        Text("$name1 :",style: TextStyle(fontWeight: FontWeight.w700),),
        SizedBox(width: 10,),
        Expanded(child: Text(name2)),
      ],
    );
  }

  Widget _cupertino( String text){
    return CupertinoTextField(readOnly: true,
      padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
      suffix: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(Icons.map),
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      style: TextStyle(color: Colors.grey.shade600),
      controller: TextEditingController(text: text),
    );
  }
}
