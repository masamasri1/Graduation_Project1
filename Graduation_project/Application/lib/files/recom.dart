import 'dart:convert';
import 'package:graduation_project/data/datasours/remote/testdata.dart';
import 'package:graduation_project/files/details.dart';
import 'package:graduation_project/link.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class recommendation extends StatefulWidget {
  final String craftmen_id;
  final String res_id;
  final String startdate;
  final String enddate;
  final String username;

  var res;

  recommendation({
    Key? key,
    required this.res_id,
    required this.craftmen_id,
    required this.startdate,
    required this.enddate,
    required this.username,
  }) : super(key: key);

  @override
  recommendationState createState() => recommendationState();
}

class recommendationState extends State<recommendation> {
  List<String> otherCraftsmenNames = [];
  String craftmanName = ''; // Added variable to store the craftman's name

  @override
  void initState() {
    super.initState();

    fetchReservationDetails();
    fetchCraftsmenData();

    print(widget.craftmen_id);
  }

  Map<String, dynamic> reservationDetails = {};

  Future<void> fetchReservationDetails() async {
    try {
      final response = await http.post(
        Uri.parse(applink.recom3), // Replace with your PHP script URL
        body: {
          'user_name': craftmanName,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == null) {
          setState(() {
            reservationDetails = data['reservationDetails'];
            print(reservationDetails);
          });
        } else {
          print('Error: ${data['error']}');
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching reservation details: $e');
    }
  }

  Future<void> fetchCraftsmenData() async {
    try {
      final response = await http.post(
        Uri.parse(applink.recom12), // replace with your PHP script URL
        body: {
          'craftmen_id': widget.craftmen_id,
          'res_id': widget.res_id,
          'start_date': widget.startdate,
          'end_date': widget.enddate
        }, // replace with the actual reservation ID
      );

      if (response.statusCode == 200) {
        print('Response body: ${response.body}');

        final data = json.decode(response.body);
        if (data['error'] == null) {
          // Check if 'craftmenData' is not null before accessing its values
          if (data['craftmenData'] != null) {
            // Access the 'user_name' inside the 'craftmenData' object
            String userName = data['craftmenData']['user_name'] ?? '';

            setState(() {
              craftmanName =
                  userName; // Use a default value if 'user_name' is null
              otherCraftsmenNames = List<String>.from(data['otherCraftsmen']);
            });
          } else {
            print('Error: No craftmenData found in the response');
          }
        } else {
          print('Error: ${data['error']}');
        }
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching craftsmen data: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCraftmenDetails(String craftmenName) async {
    final String apiUrl = applink.recom7;
    final Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    final Map<String, String> body = {'user_name': craftmenName};

    final http.Response response =
        await http.post(Uri.parse(apiUrl), headers: headers, body: body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data.containsKey('error')) {
        // Handle error
        print('Error: ${data['error']}');
        return {'error': data['error']};
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              user_Name: data['craftmen_name'],
              craftmenPhone: data['craftmen_phone'],
              price: data['price'],
              worksDuringEmergency: data['emergency'],
              reservations: [],
              craftmen_id: widget.craftmen_id,
              userName: widget.username,
              working_hours: data['working_day'],
            ),
          ),
        );
      }
      // Successful response
      return {
        'craftmen_name': data['craftmen_name'],
        'craftmen_phone': data['craftmen_phone'],
        'price': data['price'],
        'emergency': data['emergency'],
      };
    } else {
      // Handle HTTP error
      print('HTTP Error: ${response.statusCode}');
      return {'error': 'HTTP Error: ${response.statusCode}'};
    }
  }

  // Future<ReservationDetails> fetchCraftmenDetails(String craftName) async {
  //   // Make an HTTP request to your PHP script to fetch details based on the craftmenName
  //   final response = await http.post(
  //     Uri.parse(applink.recom7), // Replace with your PHP script URL
  //     body: {
  //       'user_name': craftName,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     if (data['craftmen_name'] != null) {
  //       return ReservationDetails(
  //         craftmenName: data['craftmen_name'],
  //         craftmenPhone: data['craftmen_phone'] ??
  //             "", // Provide a default value or handle null accordingly
  //         price: data['price'] ??
  //             "", // Provide a default value or handle null accordingly
  //         worksDuringEmergency: data['emergency'] ??
  //             "", // Provide a default value or handle null accordingly
  //       );

  //       print('Response Body: ${response.body}');
  //     } else {
  //       throw Exception('Error fetching craftmen details: ${data['error']}');
  //     }
  //   } else {
  //     throw Exception('HTTP error: ${response.reasonPhrase}');
  //   }
  // }

  @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Craftsmen Recommendations'),
  //     ),
  //     body: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Text('Craftsman: $craftmanName'), // Display the craftman's name
  //         SizedBox(height: 20),
  //         Text('Other Craftsmen:'),
  //         SizedBox(height: 10),
  //         Wrap(
  //           spacing: 8.0,
  //           runSpacing: 8.0,
  //           children: otherCraftsmenNames.map((craftsmanName) {
  //             return ElevatedButton(
  //               onPressed: () {
  //                 // Handle button click
  //                 print('Craftsman selected: $craftsmanName');
  //               },
  //               child: Text(craftsmanName),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Craftsmen Recommendations'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Craftsmen Recomendation'), // Display the craftsman's name
          // SizedBox(height: 20),
          // Text('Other Craftsmen:'),
          SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: otherCraftsmenNames.map((craftsmanName) {
              // Replace 'profileImageUrl' with the actual URL or local asset path
              String profileImageUrl =
                  'https://cdn-icons-png.flaticon.com/512/4128/4128273.png';

              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      // Assume you have a function to fetch details based on craftmenName
                      Map<String, dynamic> craftmenDetails =
                          await fetchCraftmenDetails('$craftsmanName');

                      // Navigate to the details page with the fetched details
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailsPage(
                      //       user_Name: details['craftmenName'],
                      //       craftmenPhone: details['craftmenPhone'],
                      //       price: details['price'],
                      //       worksDuringEmergency:
                      //           details['worksDuringEmergency'],
                      //       reservations: [],
                      //       craftmen_id: widget.craftmen_id,
                      //       userName: reservationDetails['user_name'],
                      //       working_hours: '',
                      //     ),
                      //   ),
                      // );

                      // Handle button click
                      print('Craftsman selected: $craftsmanName');
                      String craft = '$craftsmanName';
                    } catch (error) {
                      // Handle errors, such as HTTP errors or exceptions from fetchCraftmenDetails
                      print('Error: $error');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Button background color
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profileImageUrl),
                      ),
                      Text(
                        craftsmanName,
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(width: 10),
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {

                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => DetailsPage(
                //                 user_Name: ,
                //                     //'${reservationDetails['craftmen_name']}',
                //                 craftmenPhone:
                //                     ,
                //                 price: '${reservationDetails['price']}',
                //                 worksDuringEmergency:
                //                     '${reservationDetails['emergency']}',
                //                 reservations: [],
                //                 craftmen_id: widget.craftmen_id,
                //                 userName: '${reservationDetails['user_name']}',
                //               )),
                //     );
                //     // Handle button click
                //     print('Craftsman selected: $craftsmanName');
                //   },
                //   style: ElevatedButton.styleFrom(
                //     primary: Colors.white, // Button background color
                //   ),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       CircleAvatar(
                //         radius: 25,
                //         backgroundImage: NetworkImage(profileImageUrl),
                //       ),
                //       Text(
                //         craftsmanName,
                //         style: TextStyle(color: Colors.black),
                //       ),
                //       SizedBox(width: 10),
                //     ],
                //   ),
                // ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ReservationDetails {
  final String craftmenName;
  final String craftmenPhone;
  final String price;
  final String worksDuringEmergency;

  ReservationDetails({
    required this.craftmenName,
    required this.craftmenPhone,
    required this.price,
    required this.worksDuringEmergency,
  });
  factory ReservationDetails.fromJson(Map<String, dynamic> json) {
    return ReservationDetails(
      craftmenName: json['craftmen_name'],
      craftmenPhone: json['craftmen_phone'] ?? "",
      price: json['price'] ?? "",
      worksDuringEmergency: json['emergency'] ?? "",
    );
  }
}
