// // details_page.dart

// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:graduation_project/files/booking.dart';
// import 'package:http/http.dart' as http;
// import 'package:graduation_project/link.dart';

// class DetailsPage extends StatefulWidget {
//   String start_date = '';
//   String end_date = '';
//   String craftsman_id = '';
//   String user_id = '';

//   final String user_Name;
//   final String craftmenPhone;
//   final String price;
//   final String craftmen_id;
//   final String worksDuringEmergency;
//   // final List<String> reservations;
//   final List<Reservation> reservations;
//   final String userName;

//   DetailsPage({
//     required this.user_Name,
//     required this.craftmenPhone,
//     required this.price,
//     required this.worksDuringEmergency,
//     required this.reservations,
//     required this.craftmen_id,
//     required this.userName,
//   });

//   @override
//   DetailsPageState createState() => DetailsPageState();
// }

// class DetailsPageState extends State<DetailsPage> {
//   String start_date = '';
//   String end_date = '';
//   String craftsman_id = '';
//   String user_id = '';
//   List<dynamic> reservations = [];
//   late String resId;
//   late String startDate;
//   late String endDate;
//   @override
//   void initState() {
//     super.initState();
//     sendRequest();
//     print(widget.craftmen_id);
//     // _fetchCraftsmanInfo();
//   }

//   void sendRequest() async {
//     final url = applink.res;
//     if (widget.craftmen_id == null) {
//       print('Craftsmen ID is null');
//       return;
//     }
//     // Replace 'craftmen_id_value' with the actual value you want to search for

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {'craftmen_id': widget.craftmen_id},
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);

//         if (data['status'] == 'success') {
//           reservations = data['data'];

//           for (var reservation in reservations) {
//             resId = reservation['res_id'];
//             startDate = reservation['start_date'];
//             endDate = reservation['end_date'];

//             // Use resId, startDate, and endDate as needed
//             print(
//                 'Reservation ID: $resId, Start Date: $startDate, End Date: $endDate');
//           }
//         } else {
//           print('Error: ${data['message']}');
//         }
//       } else {
//         print('Error! Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error sending request: $e');
//     }
//   }

//   Future<void> _bookReservation() async {
//     // Replace with your server URL
//     var url = Uri.parse(applink.book);

//     // Send a POST request to the server
//     var response = await http.post(
//       url,
//       body: {
//         'start_date': start_date,
//         'end_date': end_date,
//         'craftsman_id': craftsman_id,
//         'user_id': user_id,
//       },
//     );

//     // Check the response from the server
//     if (response.statusCode == 200) {
//       print('Reservation successfully saved');
//     } else {
//       print('Error: ${response.body}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [
//             Color.fromARGB(255, 70, 200, 236),
//             Color.fromARGB(255, 76, 155, 207),
//           ],
//         ),
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Details Page'),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Name:  ${widget.user_Name}',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//               Text('Craftsmen Phone: ${widget.craftmenPhone}',
//                   style: TextStyle(fontSize: 16)),
//               Text('Price: ${widget.price}', style: TextStyle(fontSize: 16)),
//               SizedBox(height: 20),
//               Text(
//                 'Works During Emergency Hours: ${widget.worksDuringEmergency}',
//                 style: TextStyle(fontSize: 16),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Reservations:',
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//               Table(
//                 border: TableBorder.all(),
//                 children: [
//                   TableRow(
//                     children: [
//                       TableCell(
//                         child: Center(child: Text('Start Date')),
//                       ),
//                       TableCell(
//                         child: Center(child: Text('End Date')),
//                       ),
//                       // Add more headers if needed
//                     ],
//                   ),
//                   for (var reservation in reservations)
//                     TableRow(
//                       children: [
//                         TableCell(
//                           child: Center(child: Text(reservation.startDate)),
//                         ),
//                         TableCell(
//                           child: Center(child: Text(reservation.endDate)),
//                         ),
//                         // Add more cells if needed
//                       ],
//                     ),
//                 ],
//               ),

//               // Text(
//               //   'Reservations:',
//               //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               // ),
//               // for (String reservation in reservations)
//               //   Text(
//               //     '- $reservation',
//               //     style: TextStyle(fontSize: 16),
//               //   ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   sendRequest();
//                   // Add booking logic here
//                   // You can navigate to a booking page or show a dialog for booking confirmation
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         title: Text('Booking Confirmation'),
//                         content: BookingPage(
//                           craftmen_id: widget.craftmen_id,
//                           userName: widget.userName,
//                         ),
//                         // Text(
//                         //     'You have successfully booked $userName for \$ $price'),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('OK'),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 child: Text('Book Now'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Reservation {
//   final String start_date;
//   final String end_date;

//   Reservation({
//     required this.start_date,
//     required this.end_date,
//   });
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/files/chat.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/files/booking.dart';
import 'package:graduation_project/link.dart';

class Reservation {
  final String res_id;
  final String start_date;
  final String end_date;
  final String duration;

  Reservation(
      {required this.res_id,
      required this.start_date,
      required this.end_date,
      required this.duration});
}

class DetailsPage extends StatefulWidget {
  final String user_Name;
  final String craftmenPhone;
  final String price;
  final String worksDuringEmergency;
  final List<Reservation> reservations;
  final String craftmen_id;
  final String userName;
  final String working_hours;
  //final String City;

  DetailsPage({
    required this.user_Name,
    required this.craftmenPhone,
    required this.price,
    required this.worksDuringEmergency,
    required this.reservations,
    required this.craftmen_id,
    required this.userName,
    required this.working_hours,
    //required this.City,
    // required String duration,
  });

  @override
  DetailsPageState createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  List<Reservation> reservations = [];

  @override
  void initState() {
    super.initState();

    getUsergmail();
    // getRatings();
    getUsergmailcraft();

    // RatingData();
    getCraftsmanAverageRating();
    sendRequest();
  }

  List<String> ratings = [];

  Future<void> getRatings() async {
    try {
      var response = await http.post(
        Uri.parse(applink.showrate),
        body: {'craftmen_id': widget.craftmen_id},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            ratings = List<String>.from(responseData['data']);
          });
        } else {
          print('Failed to fetch data: ${responseData['message']}');
        }
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String gmail = '';
  List<Map<String, dynamic>> _rateData = [];
  Future<void> RatingData() async {
    try {
      var response = await http.post(Uri.parse(applink.showrate));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');

        if (responseData['status'] == 'success') {
          setState(() {
            _rateData = List<Map<String, dynamic>>.from(responseData['data']);
            print('_rateData: $_rateData');
          });
        } else {
          print('Failed to fetch data: ${responseData['message']}');
        }
      } else {
        print('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getUsergmail() async {
    try {
      var response = await http.post(
        Uri.parse(applink.gmail),
        body: {'user_name': widget.userName},
      );

      print('HTTP Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        print('User Data: $userData');

        // Check if 'gmail' key is present in the JSON response
        if (userData.containsKey('gmail')) {
          gmail = userData['gmail'];
          print(gmail);
          // You may uncomment the following lines if you are using a StatefulWidget
          // setState(() {
          //   gmailcraft = userData['gmail'];
          //   print(gmailcraft);
          // });
        } else {
          print('gmail key not found in JSON response');
        }
      } else {
        print('Error fetching user_id: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String gmailcraft = '';

  Future<void> getUsergmailcraft() async {
    try {
      var response = await http.post(
        Uri.parse(applink.gmailcraft),
        body: {'user_name': widget.user_Name},
      );

      print('HTTP Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        print('User Data: $userData');

        // Check if 'gmail' key is present in the JSON response
        if (userData.containsKey('craftmen_gmail')) {
          gmailcraft = userData['craftmen_gmail'];
          print(gmailcraft);
          // You may uncomment the following lines if you are using a StatefulWidget
          // setState(() {
          //   gmailcraft = userData['gmail'];
          //   print(gmailcraft);
          // });
        } else {
          print('gmail key not found in JSON response');
        }
      } else {
        print('Error fetching user_id: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void sendRequest() async {
    final url = applink.res;

    if (widget.craftmen_id == null) {
      print('Craftsmen ID is null');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'craftmen_id': widget.craftmen_id},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == 'success') {
          setState(() {
            reservations = (data['data'] as List)
                .map((reservation) => Reservation(
                      res_id: reservation['res_id'],
                      start_date: reservation['start_date'],
                      end_date: reservation['end_date'],
                      duration: reservation['duration'],
                    ))
                .toList();
          });
        } else {
          print('Error: ${data['message']}');
        }
      } else {
        print('Error! Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  Future<String> getCraftsmanAverageRating() async {
    final String apiUrl = applink.star; // Replace with your actual PHP API URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {'craftmen_id': widget.craftmen_id.toString()},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);

        if (data != null && data['status'] == 'success') {
          return data['average_rating']?.toString() ?? '0.0';
        } else {
          // Handle error case
          throw 'Error: ${data?['message'] ?? 'Unknown error'}';
        }
      } else {
        // Handle HTTP error
        throw 'Error: ${response.reasonPhrase}';
      }
    } catch (error) {
      // Handle other exceptions
      print('Error: $error');
      return '0.0'; // Return a default value in case of an error
    }
  }
  // Future<String> getCraftsmanAverageRating()  {
  //   final String apiUrl = applink.star;
  //   try {
  //     final response =  http.post(
  //       Uri.parse(apiUrl),
  //       body: {'craftmen_id': widget.craftmen_id},
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = json.decode(response.body);

  //       if (data['status'] == 'success') {
  //         return data['average_rating'];
  //       } else {
  //         return 'Error: ${data['message']}';
  //       }
  //     } else {
  //       return 'Error: ${response.reasonPhrase}';
  //     }
  //   } catch (e) {
  //     print('Exception: $e');
  //     return 'Error: $e';
  //   }
  // }

  Widget generateStarRating(String ratingString) {
    double rating = double.parse(ratingString);
    return Row(
      children: List.generate(5, (index) {
        double starValue = index + 1.0;
        return Icon(
          starValue <= rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 70, 200, 236),
            Color.fromARGB(255, 76, 155, 207),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Details Page'),
          actions: [
            IconButton(
              icon: Icon(Icons.chat), // Use the chat icon
              onPressed: () {
                // Add your chat button functionality here
                // For example, navigate to a chat page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => chatpage(
                            email: gmail,
                            reseve: gmailcraft,
                            namesender: widget.userName,
                            nameres: widget.user_Name,
                          )),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name:  ${widget.user_Name}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Craftsmen Phone: ${widget.craftmenPhone}',
                  style: TextStyle(fontSize: 16)),
              Text('Price: ${widget.price}', style: TextStyle(fontSize: 16)),

              // SizedBox(height: 20),
              // Text('City: ${widget.City}', style: TextStyle(fontSize: 16)),

              SizedBox(height: 20),

              Text(
                'Works During Emergency Hours: ${widget.worksDuringEmergency}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Text(
                'Working_hours: ${widget.working_hours}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Rating: ',
                    style: TextStyle(fontSize: 16),
                  ),
                  FutureBuilder<String>(
                    future: getCraftsmanAverageRating(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          'Loading...',
                          style: TextStyle(fontSize: 16),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(fontSize: 16),
                        );
                      } else {
                        return generateStarRating(snapshot.data ?? '0.0');
                      }
                    },
                  ),
                  //  generateStarRating('4'), // Assuming $rating is available
                ],
              ),
              // Add the star rating using the generateStarRating function
              // generateStarRating(),
              SizedBox(height: 20),
              Text(
                'Reservations:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Table(
                border: TableBorder.all(),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(child: Text('Reservation ID')),
                      ),
                      TableCell(
                        child: Center(child: Text('Start Date')),
                      ),
                      TableCell(
                        child: Center(child: Text('End Date')),
                      ),
                      // TableCell(
                      //   child: Center(child: Text('Duration')),
                      // ),
                    ],
                  ),
                  for (var reservation in reservations)
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(child: Text(reservation.res_id)),
                        ),
                        TableCell(
                          child: Center(child: Text(reservation.start_date)),
                        ),
                        TableCell(
                          child: Center(child: Text(reservation.end_date)),
                        ),
                        // TableCell(
                        //   child: Center(child: Text(reservation.duration)),
                        // ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  //  getCraftsmanAverageRating();
                  // Add booking logic here
                  // You can navigate to a booking page or show a dialog for booking confirmation
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Booking Confirmation'),
                        content: BookingPage(
                          craftmen_id: widget.craftmen_id,
                          userName: widget.userName,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsPage(
                                            user_Name: '',
                                            craftmenPhone: '',
                                            price: '',
                                            worksDuringEmergency: '',
                                            reservations: [],
                                            craftmen_id: '',
                                            userName: '', working_hours: '',

                                            //duration: '',
                                          )));
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
