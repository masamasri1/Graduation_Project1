// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/files/welcome.dart';
// import 'package:graduation_project/link.dart';
// import 'package:graduation_project/edituserprofile.dart';
// import 'package:http/http.dart' as http;

// class Reservation {
//   final String craftmen_id;
//   final String start_date;
//   final String end_date;

//   Reservation({
//     required this.craftmen_id,
//     required this.start_date,
//     required this.end_date,
//   });
// }

// class ReservationDialog extends StatefulWidget {
//   // final List<Map<String, dynamic>> reservations;
//   List<Reservation> reservations = [];
//   final Function refreshCallback;

//   ReservationDialog(
//       {required this.reservations, required this.refreshCallback});

//   @override
//   _ReservationDialogState createState() => _ReservationDialogState();
// }

// class _ReservationDialogState extends State<ReservationDialog> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16.0),
//       ),
//       elevation: 0.0,
//       backgroundColor: const Color.fromARGB(0, 255, 255, 255),
//       child: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.all(20.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Reservation List',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 18.0,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Table(
//                   border: TableBorder.all(),
//                   columnWidths: {
//                     0: FixedColumnWidth(150),
//                     1: FixedColumnWidth(150),
//                     2: FixedColumnWidth(150),
//                     3: FixedColumnWidth(150),
//                   },
//                   children: [
//                     TableRow(
//                       children: [
//                         TableCell(child: Center(child: Text('Craftsman'))),
//                         TableCell(child: Center(child: Text('Start Date'))),
//                         TableCell(child: Center(child: Text('End Date'))),
//                         TableCell(child: Center(child: Text('Action'))),
//                       ],
//                     ),
//                     for (var reservation in widget.reservations)
//                       TableRow(
//                         children: [
//                           TableCell(
//                               child:
//                                   Center(child: Text(reservation.craftmen_id))),
//                           TableCell(
//                               child:
//                                   Center(child: Text(reservation.start_date))),
//                           TableCell(
//                               child: Center(child: Text(reservation.end_date))),
//                           TableCell(
//                             child: Center(
//                               child: IconButton(
//                                 icon: Icon(Icons.delete),
//                                 onPressed: () {
//                                   deleteReservation();
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               ElevatedButton(
//                 onPressed: () {
//                   widget.refreshCallback();
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('Refresh'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> deleteReservation() async {
//     final response = await http
//         .delete(Uri.parse('http://your-php-backend.com/api/reservations'));

//     if (response.statusCode == 200) {
//       widget.refreshCallback();
//     } else {
//       print('Failed to delete reservation');
//     }
//   }
// }
