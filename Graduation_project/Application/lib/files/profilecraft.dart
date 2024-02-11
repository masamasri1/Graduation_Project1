import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/files/chat.dart';
import 'package:graduation_project/files/crp.dart';
import 'package:graduation_project/files/recom.dart';
import 'package:graduation_project/files/welcome.dart';
import 'package:graduation_project/main.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/link.dart';

class CraftsmenProfilePage extends StatefulWidget {
  final String craftsmanName;

  CraftsmenProfilePage({required this.craftsmanName});

  @override
  State<CraftsmenProfilePage> createState() => _CraftsmenProfilePageState();
}

class _CraftsmenProfilePageState extends State<CraftsmenProfilePage> {
  String? craftsmanName;
  static Future<List<String>> fetchEventsFromDatabase() async {
    await Future.delayed(Duration(seconds: 2));
    return ["Event 1", "Event 2", "Event 3"];
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
    getUserID();
    _fetchCraftsmanInfo();
    // getUsergmail();
    getUsergmailcraft();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleForegroundMessage(message);
    });
  }

  String gmailcraft = '';

  Future<void> getUsergmailcraft() async {
    try {
      var response = await http.post(
        Uri.parse(applink.gmailcraft),
        body: {'user_name': widget.craftsmanName},
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

  String userId = "";

  Future<void> getUserID() async {
    try {
      var response = await http.post(
        Uri.parse(applink.cid),
        body: {'user_name': widget.craftsmanName},
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

  _fetchUserDetails() async {
    final response = await http.get(Uri.parse(applink.pc));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        craftsmanName = data['user_name'];
      });
    }
  }

  // _fetchUserDetails() async {
  //   final response = await http.get(Uri.parse(applink.pc));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     setState(() {
  //       craftsmanName = data['user_name'];
  //     });
  //   }
  // }

  Future<void> _sendFCMTokenToServer() async {
    var notificationUrl = Uri.parse(applink.jobdone);

    try {
      var response = await http.post(
        notificationUrl,
        body: {
          'user_id':
              userId, // Make sure this matches the expected variable name on the server
          'fcm_token':
              'frPkkRyIR024pM7D9cTVpl:APA91bF7uZvlXwMT5OPW6FzEuXqJmPnxvAhW2uuBE-wjty8T0J09iWiflE2RCpu8vvpQKT06fc53faWB14O1NuWhM7eW486OsDAiDm00wQHk6-wN6HUmGeizYhCQeV_QUUIxkABVs04S',
          'message': 'You can pay now',
        },
      );

      if (response.statusCode == 200) {
        print('FCM Token sent to server successfully');
      } else {
        print('Error sending FCM Token to server: ${response.body}');
      }
    } catch (e) {
      print('Error sending FCM Token to server: $e');
    }
  }

//.........................................................................
  List<Map<String, dynamic>> craftsmanInfoList = [];
  String username = '';

  Future<void> _fetchCraftsmanInfo() async {
    try {
      var response = await http.post(
        Uri.parse(applink.event),
        body: {'craftmen_id': userId},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        if (data is List) {
          setState(() {
            craftsmanInfoList = List<Map<String, dynamic>>.from(data);
            print(craftsmanInfoList);
          });
        } else {
          print('Error: Invalid response format');
        }
      } else {
        print('Error fetching craftsman info: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  String reid = '';
  Future<void> deleteReservation() async {
    //for (var reservation in reservations) reid = reservation.res_id;
    for (var info in craftsmanInfoList) reid = '${info['res_id']}';
    try {
      var response = await http.post(
        Uri.parse(applink.rdelete),
        body: {'res_id': reid},
      );
      print(reid);
      if (response.statusCode == 200) {
        // Successful deletion
        print("Reservation deleted successfully");
        sendFCMTokenToServer();
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

  String mess = "reservation deleted";
  String userToken =
      'frPkkRyIR024pM7D9cTVpl:APA91bF7uZvlXwMT5OPW6FzEuXqJmPnxvAhW2uuBE-wjty8T0J09iWiflE2RCpu8vvpQKT06fc53faWB14O1NuWhM7eW486OsDAiDm00wQHk6-wN6HUmGeizYhCQeV_QUUIxkABVs04S';
  // Future<void> sendFCMTokenToServer() async {
  //   var notificationUrl = Uri.parse(applink.recom);

  //   try {
  //     var response = await http.post(
  //       notificationUrl,
  //       body: {
  //         'fcm_token':
  //             'frPkkRyIR024pM7D9cTVpl:APA91bF7uZvlXwMT5OPW6FzEuXqJmPnxvAhW2uuBE-wjty8T0J09iWiflE2RCpu8vvpQKT06fc53faWB14O1NuWhM7eW486OsDAiDm00wQHk6-wN6HUmGeizYhCQeV_QUUIxkABVs04S',
  //         //'d9ry4DGpRU68xRe9ZorkgM:APA91bF-mc5r7a7jfaX9pf9ksS7AcHsaiHnBLGod3mXMuPu5LTHB9gMWNOF0YL3cfbzYEwxbKkjOOxA1mXg6ohvGwvqyX5Tb0bLCeP0rIzbC3H3Fvx-OjEEK-PGymK4qtTtQWfs1RPqQ',
  //         'notification_type': 'recommendation',
  //         'message': 'Reservation deleted',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       print('FCM Token sent to server successfully');
  //       print(userId);
  //       print(reid);
  //       for (var info in craftsmanInfoList) print('${info['start_date']}');

  //       //  handleForegroundMessage(message);
  //       FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //         handleForegroundMessage(message);
  //       });
  //     } else {
  //       print('Error sending FCM Token to server: ${response.body}');
  //     }
  //     //FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     //    handleForegroundMessage(message);
  //     // });
  //   } catch (e) {
  //     print('Error sending FCM Token to server: $e');
  //   }
  // }
  Future<void> sendFCMTokenToServer() async {
    var notificationUrl = Uri.parse(applink.recom);

    try {
      var response = await http.post(
        notificationUrl,
        body: {
          'fcm_token':
              'frPkkRyIR024pM7D9cTVpl:APA91bF7uZvlXwMT5OPW6FzEuXqJmPnxvAhW2uuBE-wjty8T0J09iWiflE2RCpu8vvpQKT06fc53faWB14O1NuWhM7eW486OsDAiDm00wQHk6-wN6HUmGeizYhCQeV_QUUIxkABVs04S',
          'notification_type': ' go to recommendations',
          'message': 'Reservation deleted',
        },
      );

      if (response.statusCode == 200) {
        print('FCM Token sent to server successfully');
        print(userId);
        print(reid);
        for (var info in craftsmanInfoList) print('${info['start_date']}');

        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
          handleForegroundMessage1(message);
        });
      } else {
        print('Error sending FCM Token to server: ${response.body}');
      }
    } catch (e) {
      print('Error sending FCM Token to server: $e');
    }
  }

  // void handleForegroundMessage(RemoteMessage message) {
  //   final data = message.data;

  //   if (data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
  //     // Extract parameters from the notification payload
  //     String notificationType = data['notification_type'] ?? '';

  //     // Determine the target page based on the notification type
  //     if (notificationType == 'recommendation') {
  //       // Recommendation-specific parameters
  //       // String craftmenId = data['craftmen_id'] ?? '';
  //       // String resId = data['res_id'] ?? '';
  //       // String startDate = data['start_date'] ?? '';
  //       // String endDate = data['end_date'] ?? '';
  //       // String username = data['user_name'] ?? '';
  //       for (var info in craftsmanInfoList)
  //         // Navigate to the Recommendation page
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => recommendation(
  //                 craftmen_id: userId,
  //                 res_id: reid,
  //                 startdate: '${info['start_date']}',
  //                 enddate: '${info['end_date']}',
  //                 username: '${info['user_name']}'),
  //           ),
  //         );
  //     } else if (notificationType == 'other_page') {
  //       // Handle other types of notifications and navigate accordingly
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => MyApp(),
  //         ),
  //       );
  //     } else {
  //       // Handle unknown notification type or default to a specific page
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => Welcome(),
  //         ),
  //       );
  //     }
  //   }
  // }
  void handleForegroundMessage(RemoteMessage message) {
    final data = message.data;

    if (data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
      // Extract parameters from the notification payload
      String notificationType = data['notification_type'] ?? '';
      String craftmenId = data['craftmen_id'] ?? '';
      String resId = data['res_id'] ?? '';
      String startdate = data['start_date'] ?? '';
      String enddate = data['end_date'] ?? '';
      String username = data['user_name'] ?? '';

      // Navigate to the Recommendation page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => recommendation(
            craftmen_id: craftmenId,
            res_id: resId,
            startdate: startdate,
            enddate: enddate,
            username: username,
          ),
        ),
      );
    } else {
      // Handle other actions or default action
      // For example, navigate to a default page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
      );
    }
  }

  // Future<void> sendNotificationToUser() async {
  //   try {
  //     // Send push notification using Firebase Cloud Messaging
  //     await FirebaseMessaging.instance.subscribeToTopic(userToken);

  //     await http.post(
  //       Uri.parse('https://fcm.googleapis.com/fcm/send'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //          'Authorization':
  //          'AAAAn9tZv8U:APA91bFiPSZaVkm2KygNE3RIpBcgtqdhCIKPmGbhyE-AIJvTmWXQ8YHdIHcY7iuyEPmjutxMrds5sJ32yHNE83vtR4SxuvEyr7I1KEZ0HoWW_sBujurPt7P1k-KwWhQe5XA8gtyHRs0H', // Replace with your server key
  //       },
  //       body: jsonEncode(
  //         <String, dynamic>{
  //           'to': userToken,
  //           'data': {
  //             'click_action': 'FLUTTER_NOTIFICATION_CLICK',
  //             'screen': 'recommendation',
  //           },
  //           'notification': {
  //             'title': 'Reservation Deleted',
  //             'body': 'Your reservation has been successfully deleted.',
  //           },
  //         },
  //       ),
  //     );

  //   } catch (error) {
  //     print("Error sending notification: $error");
  //   }
  // }
//FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //    handleForegroundMessage(message);
  // });
  void handleForegroundMessage1(RemoteMessage message) {
    // Extract the data from the message
    final data = message.data;

    // Check if the click action is specified and navigate accordingly
    if (data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
      // Check for specific conditions based on the notification data
      if (data['specific_condition'] == 'some_value') {
        // Navigate to the recommendation page with parameters
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => recommendation(
              craftmen_id: '${data['craftmen_id']}',
              res_id: '${data['res_id']}',
              startdate: '${data['start_date']}',
              enddate: '${data['end_date']}',
              username: '${data['user_name']}',
            ),
          ),
        );
      }
    }
  }

  // void handleForegroundMessage(RemoteMessage message) {
  //   // Extract the data from the message
  //   final data = message.data;

  //   // Check if the click action is specified and navigate accordingly
  //   if (data['click_action'] == 'FLUTTER_NOTIFICATION_CLICK') {
  //     for (var info in craftsmanInfoList)
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => recommendation(
  //             craftmen_id: ' ${info['craftmen_id']}',
  //             res_id: ' ${info['res_id']}',
  //             startdate: '${info['start_date']}',
  //             enddate: ' ${info['end_date']}',
  //             username: '${info['user_name']}',
  //           ),
  //         ),
  //       );
  //     // Navigate to the recommendation page
  //     // Note: You may need to use the appropriate navigation method based on your app's navigation setup
  //     Navigator.of(context).pushNamed('/recommendation');
  //   }
  // }

  Future<void> _showEventsDialog() async {
    // Capture the current context synchronously
    BuildContext currentContext = context;

    await _fetchCraftsmanInfo();
    return showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reservations Information'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var info in craftsmanInfoList)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          showDetailsDialog(context, info);

                          recommendation(
                            craftmen_id: ' ${info['craftmen_id']}',
                            res_id: ' ${info['res_id']}',
                            startdate: '${info['start_date']}',
                            enddate: ' ${info['end_date']}',
                            username: '${info['user_name']}',
                          );
                        },
                        child: Text(info['user_name']),
                      ),
                    ),
                    SizedBox(
                        height:
                            10.0), // Adjust the height for spacing between buttons
                  ],
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(currentContext).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void showDetailsDialog(BuildContext context, Map<String, dynamic> info) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.chat), // Use the chat icon
                onPressed: () {
                  // Add your chat button functionality here
                  // For example, navigate to a chat page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => chatpage(
                        email: gmailcraft,
                        reseve: '${info['gmail']}',
                        namesender: widget.craftsmanName,
                        nameres: '${info['user_name']}',
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 8),
              Text(
                'Reservations Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Start Date: ${info['start_date']}',
                  style: TextStyle(fontSize: 16)),
              Text('End Date: ${info['end_date']}',
                  style: TextStyle(fontSize: 16)),
              Text('User Name: ${info['user_name']}',
                  style: TextStyle(fontSize: 16)),
              Text('Phone Number: ${info['phone_number']}',
                  style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _sendFCMTokenToServer();
                    },
                    child: Text('Done', style: TextStyle(fontSize: 16)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Add your delete reservation functionality here
                      // For example, show a confirmation dialog
                      deleteReservation();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => recommendation(
                              craftmen_id: userId,
                              res_id: reid,
                              startdate: '${info['start_date']}',
                              enddate: '${info['end_date']}',
                              username: '${info['user_name']}'),
                        ),
                      );

                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CraftsmenProfilePage(
                      //         craftsmanName: widget.craftsmanName,
                      //       ),
                      //     ),
                      //   );
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: Text('Delete', style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name:  ${craftsmanName ?? widget.craftsmanName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ElevatedButton(
                //   onPressed: () async {
                //     // Fetch craftsman info when Events button is pressed
                //     await _fetchCraftsmanInfo();
                //     // Show the events dialog with craftsman info
                //     _showEventsDialog([]);
                //   },
                //   child: Text('Events'),
                // ),
                Row(children: [
                  IconButton(
                    icon: Icon(Icons.event),
                    onPressed: () async {
                      // Fetch and show events
                      // List<String> events = await fetchEventsFromDatabase();
                      _showEventsDialog();
                    },
                  ),
                  Text(
                    'Show your Reservations',
                    style: TextStyle(fontSize: 20),
                  ),
                ]),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Implement navigation to the edit profile page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => editProfilePage(),
                          ),
                        );
                      },
                    ),
                    Text(
                      'Edit  Your Profile',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),

                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () {
                        // Implement exit logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => chatpage(
                              email: gmailcraft,
                              reseve: 'mosamis.2000@gmail.com',
                              namesender: widget.craftsmanName,
                              nameres: 'Masa Masri',
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      'Chat With Admin',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        // Implement exit logic here
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                    ),
                    Text(
                      'Log out',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Profile'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Name:  ${craftsmanName ?? widget.craftsmanName}',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Events:',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             FutureBuilder(
//               future: fetchEventsFromDatabase(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   List<String>? events = snapshot.data;
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: events?.map((event) {
//                           return Text('- $event',
//                               style: TextStyle(fontSize: 16));
//                         }).toList() ??
//                         [],
//                   );
//                 }
//               },
//             ),
//             SizedBox(height: 32),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.event),
//                   onPressed: () async {
//                     // Fetch and show events
//                     List<String> events = await fetchEventsFromDatabase();
//                     _showEventsDialog(events);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     // Implement navigation to the edit profile page
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => editProfilePage()));
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.exit_to_app),
//                   onPressed: () {
//                     // Implement exit logic here
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Welcome()));
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
}
