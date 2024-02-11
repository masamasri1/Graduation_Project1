import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/files/chat.dart';
import 'package:graduation_project/files/paypal.dart';
import 'package:graduation_project/files/recom.dart';
import 'package:graduation_project/files/testvi.dart';
import 'package:graduation_project/files/welcome.dart';
import 'package:graduation_project/link.dart';
import 'package:graduation_project/edituserprofile.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:image_picker/image_picker.dart';

class Reservation {
  final String user_name;
  final String start_date;
  final String end_date;
  final String res_id;
  final String price;
  final String duration;
  final String craftmen_id;
  Reservation({
    required this.user_name,
    required this.start_date,
    required this.end_date,
    required this.res_id,
    required this.price,
    required this.duration,
    required this.craftmen_id,
  });
}

class menu extends StatefulWidget {
  final String userName;

  menu({required this.userName});

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<menu> {
  String? userName;
  //List<Map<String, dynamic>> reservations = [];
  List<Reservation> reservations = [];
  List<Reservation> reservations1 = [];

  @override
  void initState() {
    super.initState();
    //_fetchUserDetails();
    getUserID();
    getUsergmail();

    // deleteReservation();
  }

  String gmail = '';
  // List<Map<String, dynamic>> craftsmanInfoList = [];
  // String username = '';

  // Future<void> _fetchCraftsmanInfo() async {
  //   for (var reservation in reservations)
  //     try {
  //       var response = await http.post(
  //         Uri.parse(applink.event),
  //         body: {'craftmen_id': reservation.craftmen_id},
  //       );

  //       if (response.statusCode == 200) {
  //         var data = jsonDecode(response.body);

  //         if (data is List) {
  //           setState(() {
  //             craftsmanInfoList = List<Map<String, dynamic>>.from(data);
  //             print(craftsmanInfoList);
  //           });
  //         } else {
  //           print('Error: Invalid response format');
  //         }
  //       } else {
  //         print('Error fetching craftsman info: ${response.body}');
  //       }
  //     } catch (e) {
  //       print('Error: $e');
  //     }
  // }

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

  String userId = "";

  void getUserID() async {
    try {
      var response = await http.post(
        Uri.parse(applink.id),
        body: {'user_name': widget.userName},
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        setState(() {
          userId = userData['user_id'].toString();
          print(userId);
        });
      } else {
        print('Error fetching user_id: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void fetchReservations() async {
    final url = applink.reuser;

    if (userId == null || userId.isEmpty) {
      print('User ID is null or empty');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'user_id': userId},
      );

      print(userId);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          setState(() {
            reservations = responseData
                .map((reservation) => Reservation(
                      user_name: reservation['user_name'],
                      start_date: reservation['start_date'],
                      end_date: reservation['end_date'],
                      res_id: reservation['res_id'],
                      price: reservation['price'],
                      duration: reservation['duration'],
                      craftmen_id: reservation['craftmen_id'],
                    ))
                .toList();
          });
        } else if (responseData is Map<String, dynamic>) {
          // Handle map response (if needed)
          print('Received map response: $responseData');
        } else {
          print('Error: Unexpected response format');
          print('Raw response: ${response.body}');
        }
      } else {
        print('Error! Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  void fetchReservations1() async {
    final url = applink.fff;

    if (userId == null || userId.isEmpty) {
      print('User ID is null or empty');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'user_id': userId},
      );

      print(userId);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          setState(() {
            reservations1 = responseData
                .map((reservation) => Reservation(
                      user_name: reservation['user_name'],
                      start_date: reservation['start_date'],
                      end_date: reservation['end_date'],
                      res_id: reservation['res_id'],
                      price: reservation['price'],
                      duration: reservation['duration'],
                      craftmen_id: reservation['craftmen_id'],
                    ))
                .toList();
          });
        } else if (responseData is Map<String, dynamic>) {
          // Handle map response (if needed)
          print('Received map response: $responseData');
        } else {
          print('Error: Unexpected response format');
          print('Raw response: ${response.body}');
        }
      } else {
        print('Error! Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }

  String reid = '';
  void showReservationDialog({
    required BuildContext context,
    required List<Reservation> reservations,
    required Function fetchReservations,
  }) {
    fetchReservations(); // Call fetchReservations when showing the dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _buildReservationDialog(
            context, reservations, fetchReservations);
      },
    );
  }

  // String result = '';

  // Future<void> getPrice() async {
  //   final url = applink.getprice; // Replace with your backend URL

  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       body: {'craftmen_id':},
  //     );

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         result = response.body;
  //         print(result);
  //       });
  //     } else {
  //       setState(() {
  //         result = 'Error: ${response.statusCode}';
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       result = 'Error: $error';
  //     });
  //   }
  // }

  Widget _buildReservationDialog(BuildContext context,
      List<Reservation> reservations, Function refreshCallback) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      child: Container(
        width: 500.0, // Adjust the width as needed
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Reservation List',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 20.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FixedColumnWidth(150),
                  1: FixedColumnWidth(150),
                  2: FixedColumnWidth(150),
                  3: FixedColumnWidth(150),
                  4: FixedColumnWidth(150),
                },
                children: [
                  TableRow(
                    children: [
                      TableCell(child: Center(child: Text('Craftsman'))),
                      TableCell(child: Center(child: Text('Start Date'))),
                      TableCell(child: Center(child: Text('End Date'))),
                      TableCell(child: Center(child: Text('Action'))),
                      TableCell(child: Center(child: Text('Pay'))),
                    ],
                  ),
                  for (var reservation in reservations)
                    TableRow(
                      children: [
                        TableCell(
                            child: Center(child: Text(reservation.user_name))),
                        TableCell(
                            child: Center(child: Text(reservation.start_date))),
                        TableCell(
                            child: Center(child: Text(reservation.end_date))),
                        TableCell(
                          child: Center(
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                deleteReservation();
                              },
                            ),
                          ),
                        ),
                        TableCell(
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePage(
                                              title: '',
                                              price: reservation.price,
                                              duration: reservation.duration,
                                              craftmen_id:
                                                  reservation.craftmen_id,
                                              user_id: userId,
                                              reid: reservation.res_id,
                                            )));
                                // getPrice();
                              },
                              child:
                                  Text('Pay'), // Set the button text to 'Pay'
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // refreshCallback();
                fetchReservations();
                Navigator.of(context).pop();
              },
              child: Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }

  File? selectimage;

  Future imagep() async {
    final returnphoto =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectimage = File(returnphoto!.path);
    });
  }

  Future refreshCallback() async {}
  Future<void> deleteReservation() async {
    for (var reservation in reservations) reid = reservation.res_id;

    try {
      var response = await http.post(
        Uri.parse(applink.rdelete),
        body: {'res_id': reid},
      );
      print(reid);
      if (response.statusCode == 200) {
        // Successful deletion
        print("Reservation deleted successfully");
        //ReservationData(); // Implement a function to fetch updated reservation data
      } else {
        // Handle error
        print("Failed to delete reservation: ${response.reasonPhrase}");
        // Optionally, show a snackbar or dialog to inform the user about the error
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      // Optionally, show a snackbar or dialog to inform the user about the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.userName),
            accountEmail: Text(''),
            // currentAccountPicture: Stack(
            //   children: [
            //     CircleAvatar(
            //       child: ClipOval(
            //         child: Icon(
            //           Icons.person,
            //           size: 90,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       bottom: 30.0,
            //       right: 12.0,
            //       child: GestureDetector(
            //         onTap: () {
            //           imagep();
            //           // Handle camera icon click here
            //           // You can navigate to the camera screen or perform any desired action
            //           print('Camera icon clicked');
            //         },
            //         child: CircleAvatar(
            //           radius: 15,
            //           backgroundColor: Colors.blue,
            //           child: Icon(
            //             Icons.camera,
            //             size: 10.0,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ),
            //     // selectimage != null
            //     //     ? Image.file(selectimage!)
            //     //     : Text("select image")
            //   ],
            // ),
            // decoration: BoxDecoration(
            //   color: Colors.blue,
            //   image: DecorationImage(
            //     fit: BoxFit.fill,
            //     image: NetworkImage(
            //         'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
            //   ),
            // ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Icon(
                  Icons.person,
                  size: 90,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
              leading: Icon(Icons.event),
              title: Text('my reservations '),
              onTap: () async {
                // await showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return ReservationDialog(
                //       reservations: reservations,
                //       refreshCallback: fetchReservations,
                //     );
                //   },
                // );
                showReservationDialog(
                    context: context,
                    reservations: reservations,
                    fetchReservations: fetchReservations);
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.chat),
              title: Text('chat with admin'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => chatpage(
                              email: gmail,
                              reseve: 'mosamis.2000@gmail.com',
                              namesender: widget.userName,
                              nameres: 'Masa Masri',
                            )));
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.event_available),
              title: Text('Recomendations'),
              onTap: () {
                fetchReservations1();
                for (var reservation1 in reservations1)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => recommendation(
                          craftmen_id: reservation1.craftmen_id,
                          res_id: reservation1.res_id,
                          startdate: reservation1.start_date,
                          enddate: reservation1.end_date,
                          username: widget.userName,
                        ),
                      ));
              }),
          Divider(),
          ListTile(
              title: Text('Log out'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Welcome()));
              }),
        ],
      ),
    );
  }
}
