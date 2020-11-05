//
//
//
// import 'package:flutter/material.dart';
// import 'package:haweyati_supplier_driver_app/src/services/haweyati-service.dart';
// import 'package:haweyati_supplier_driver_app/widgits/simple-stream-builder.dart';
// import 'package:web_socket_channel/io.dart';
//
// class WebSocketsTesting extends StatefulWidget {
//   @override
//   _WebSocketsTestingState createState() => _WebSocketsTestingState();
// }
//
// class _WebSocketsTestingState extends State<WebSocketsTesting> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     print(apiUrl);
//     return Scaffold(
//       body: SimpleStreamBuilder.simpler(
//         context: context,
//         stream: IOWebSocketChannel.connect('ws://${apiUrl}').stream,
//         builder: (snapshot){
//           return Text(snapshot.data);
//         },
//       )
//     );
//   }
// }
