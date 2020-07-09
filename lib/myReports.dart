import 'package:flutter/material.dart';
import 'package:haweyati_supplier_driver_app/src/const.dart';
import 'package:haweyati_supplier_driver_app/widgits/scrollable_page.dart';

class MyReportsPage extends StatefulWidget {
  @override
  _MyReportsPageState createState() => _MyReportsPageState();
}

class _MyReportsPageState extends State<MyReportsPage> {

String path ="C:\Users\Osama\Downloads";
bool isReady ;


@override

  Widget build(BuildContext context) {
    return
//      PDFView(
//      filePath: path,
//      enableSwipe: true,
//      swipeHorizontal: true,
//      autoSpacing: false,
//      pageFling: false,
//      onRender: (_pages) {
//        setState(() {
//          pages = _pages;
//          isReady = true;
//        });
//      },
//      onError: (error) {
//        print(error.toString());
//      },
//      onPageError: (page, error) {
//        print('$page: ${error.toString()}');
//      },
//      onViewCreated: (PDFViewController pdfViewController) {
//        _controller.complete(pdfViewController);
//      },
//      onPageChanged: (int page, int total) {
//        print('page change: $page/$total');
//      },
//    );



      ScrollablePage(title: "Reports",subtitle: loremIpsum.substring(0,69),child: SliverList(delegate: SliverChildBuilderDelegate((context,i){

      return Column(
        children: <Widget>[

          ListTile(
            leading:Icon(Icons.report),
            //     Image.asset("assets/images/notification_thumb.png",height: 40,width: 40,),
            title: Text(loremIpsum.substring(0,60)),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text("12:30 PM"),
            ),     ),
          Divider()
        ],
      );
    })),);
      
      

  }
}
