// import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
// import 'package:flutter/material.dart';
//
//
//
// class MyApp2 extends StatefulWidget {
//   const MyApp2({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp2> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyApp2> {
//   String barcode = 'Tap  to scan';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(' Scanner'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               child: const Text('Scan Barcode'),
//               onPressed: () async {
//                 await Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (context) => AiBarcodeScanner(
//                       //    validateText: 'https://', // link to be validated
//                       //   validateType: ValidateType.startsWith,
//                       onScan: (String value) {
//                         debugPrint(value);
//                         setState(() {
//                           barcode = value;
//                         });
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//             Text(barcode),
//           ],
//         ),
//       ),
//     );
//   }
// }