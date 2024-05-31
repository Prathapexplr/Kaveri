// import 'package:flutter/material.dart';
// import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

// class Calendar extends StatelessWidget {
//   DateTime? _selectedDate;

//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           ElevatedButton(
//             child: const Text("Show picker widget"),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     backgroundColor: Colors.white,
//                     content: SizedBox(
//                       height: 230,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 25),
//                             child: DatePickerWidget(
//                               looping: false, // default is not looping
//                               firstDate: DateTime.now(),
//                               //  lastDate: DateTime(2002, 1, 1),
//                               //              initialDate: DateTime.now(),// DateTime(1994),
//                               dateFormat:
//                                   // "MM-dd(E)",
//                                   "MMMM/yyyy",
//                               locale: DatePicker.localeFromString('en'),
//                               onChange: (DateTime newDate, _) {
//                                 // setState(() {
//                                 _selectedDate = newDate;
//                                 // });
//                                 print(_selectedDate);
//                               },
//                               pickerTheme: const DateTimePickerTheme(
//                                 backgroundColor: Colors.transparent,
//                                 itemTextStyle: TextStyle(
//                                     color: Color.fromARGB(255, 44, 211, 249),
//                                     fontSize: 19),
//                                 dividerColor: Color.fromARGB(255, 0, 0, 0),
//                               ),
//                             ),
//                           ),

//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               TextButton(
//                                 child: const Text(
//                                   'Cancel',
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                               TextButton(
//                                 child: const Text(
//                                   'Ok',
//                                 ),
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             ],
//                           )

//                           // Text("${_selectedDate ?? ''}"),
//                         ],
//                       ),
//                     ),
//                     // actions: [
//                     //   TextButton(
//                     //     child: const Text(
//                     //       'Cancel',
//                     //     ),
//                     //     onPressed: () {
//                     //       Navigator.of(context).pop();
//                     //     },
//                     //   ),
//                     //   // const SizedBox(
//                     //   //   width: 10,
//                     //   // ),
//                     //   TextButton(
//                     //     child: const Text('Ok'),
//                     //     onPressed: () {
//                     //       Navigator.of(context).pop();
//                     //     },
//                     //   ),
//                     // ],
//                   );
//                 },
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// // class WidgetPage extends StatefulWidget {
// //   @override
// //   _WidgetPageState createState() => _WidgetPageState();
// // }

// // class _WidgetPageState extends State<WidgetPage> {
  

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       child: Scaffold(
// //         body: Container(
// //           decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //             begin: FractionalOffset.topCenter,
// //             end: FractionalOffset.bottomCenter,
// //             colors: [
// //               Colors.grey[900]!,
// //               Colors.black,
// //             ],
// //             stops: const [0.7, 1.0],
// //           )),
// //           child: Center(
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 25),
// //                   child: DatePickerWidget(
// //                     looping: false, // default is not looping
// //                     firstDate: DateTime.now(),
// //                     //  lastDate: DateTime(2002, 1, 1),
// // //              initialDate: DateTime.now(),// DateTime(1994),
// //                     dateFormat:
// //                         // "MM-dd(E)",
// //                         "MMMM/yyyy",
// //                     locale: DatePicker.localeFromString('en'),
// //                     onChange: (DateTime newDate, _) {
// //                       setState(() {
// //                         _selectedDate = newDate;
// //                       });
// //                       print(_selectedDate);
// //                     },
// //                     pickerTheme: DateTimePickerTheme(
// //                       backgroundColor: Colors.transparent,
// //                       itemTextStyle:
// //                           TextStyle(color: Colors.white, fontSize: 19),
// //                       dividerColor: Colors.white,
// //                     ),
// //                   ),
// //                 ),
// //                 Text("${_selectedDate ?? ''}"),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //     //var locale = "zh";
// //     // return SafeArea(
// //     //   child: Scaffold(
// //     //     body: Center(
// //     //       child: DatePickerWidget(
// //     //         locale: //locale == 'zh'
// //     //             DateTimePickerLocale.zh_cn
// //     //             //  DateTimePickerLocale.en_us
// //     //         ,
// //     //         lastDate: DateTime.now(),
// //     //         // dateFormat: "yyyy : MMM : dd",
// //     //         // dateFormat: 'yyyy MMMM dd',
// //     //         onChange: (DateTime newDate, _) {
// //     //           setState(() {
// //     //             var dob = newDate.toString();
// //     //             print(dob);
// //     //           });
// //     //         },
// //     //         pickerTheme: DateTimePickerTheme(
// //     //           backgroundColor: Colors.transparent,
// //     //           dividerColor: const Color(0xffe3e3e3),
// //     //           itemTextStyle: TextStyle(
// //     //             fontFamily: 'NotoSansTC',
// //     //             fontSize: 18,
// //     //             fontWeight: FontWeight.w500,
// //     //             color: Theme.of(context).primaryColor,
// //     //           ),
// //     //         ),
// //     //       ),
// //     //     ),
// //     //   ),
// //     // );
// //   }
// // }
