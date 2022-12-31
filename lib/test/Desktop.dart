// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui' as ui;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
// import 'package:supermarket/test/utils.dart';
// import 'package:flutter/material.dart';
// import 'package:visibility_detector/visibility_detector.dart';
// import 'package:flutter_barcode_listener/flutter_barcode_listener.dart';
// import 'utils.dart';
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String? _barcode;
//   late bool visible;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Add visiblity detector to handle barcode
//         // values only when widget is visible
//         child: VisibilityDetector(
//           onVisibilityChanged: (VisibilityInfo info) {
//             visible = info.visibleFraction > 0;
//           },
//           key: Key('visible-detector-key'),
//           child: BarcodeKeyboardListener(
//             bufferDuration: Duration(milliseconds: 200),
//             onBarcodeScanned: (barcode) {
//               if (!visible) return;
//               print(barcode);
//               setState(() {
//                 _barcode = barcode;
//               });
//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   _barcode == null ? 'SCAN BARCODE' : 'BARCODE: $_barcode',
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: ElevatedButton(
//                       onPressed: () => Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   SecondScreen())),
//                       child: Center(child: Text('Second screen'))),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }