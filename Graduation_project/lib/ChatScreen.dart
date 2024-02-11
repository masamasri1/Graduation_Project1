import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/admincraftmen.dart';
import 'package:flutter_responsive/adminuser.dart';
import 'package:flutter_responsive/main.dart';
import 'package:flutter_responsive/massag.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'connection/connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class chatpage extends StatefulWidget {
  String email;
  String reseve;
  chatpage({super.key, required this.email, required this.reseve});
  @override
  _chatpageState createState() => _chatpageState(email: email, reseve: reseve);
}

class _chatpageState extends State<chatpage> {
  String email;
  String reseve;
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _craftmenData = [];
  _chatpageState({required this.email, required this.reseve});

  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final TextEditingController message = new TextEditingController();

  Future<void> adminData() async {
    var response = await http.post(Uri.parse(applink.showadmin));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          _adminData = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        // Handle failure
        print('Failed to fetch data: ${responseData['message']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP error: ${response.statusCode}');
    }
  }

  Future<void> fetchData() async {
    var response = await http.post(Uri.parse(applink.showuser));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          _userData = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        // Handle failure
        print('Failed to fetch data: ${responseData['message']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP error: ${response.statusCode}');
    }
  }

  Future<void> craftmenData() async {
    var response = await http.post(Uri.parse(applink.showcraftmen));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData['status'] == 'success') {
        setState(() {
          _craftmenData = List<Map<String, dynamic>>.from(responseData['data']);
        });
      } else {
        // Handle failure
        print('Failed to fetch data: ${responseData['message']}');
      }
    } else {
      // Handle HTTP error
      print('HTTP error: ${response.statusCode}');
    }
  }

  void initState() {
    super.initState();
    fetchData();
    craftmenData();
    adminData();
    // getFirebaseMessagingToken(email);
  }

  String? getNameFromEmail(String email) {
    String? name;
    if (_adminData.any((map) => map['admin_gmail'] == email)) {
      name = _adminData
          .firstWhere((map) => map['admin_gmail'] == email)['admin_name'];
    } else if (_userData.any((map) => map['gmail'] == email)) {
      name = _userData.firstWhere((map) => map['gmail'] == email)['user_name'];
    } else if (_craftmenData.any((map) => map['craftmen_gmail'] == email)) {
      name = _craftmenData
          .firstWhere((map) => map['craftmen_gmail'] == email)['user_name'];
    } else {
      // Handle the case when the email is not found in either list
      name = null;
    }

    print(name);
    return name;
  }

  List<Map<String, dynamic>> notification = [];

  // Future<void> getFirebaseMessagingToken(String email) async {
  //   try {
  //     await FirebaseMessaging.instance.requestPermission();
  //     await FirebaseMessaging.instance
  //         .setForegroundNotificationPresentationOptions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );

  //     String? token = await FirebaseMessaging.instance.getToken();
  //     if (token != null) {
  //       print('FCM Token: $token');
  //       notification.add({
  //         'token': token,
  //         'email': email,
  //         'name': getNameFromEmail(email),
  //       });
  //     }
  //   } catch (e) {
  //     print('Error getting FCM token: $e');
  //   }
  // }
  // Future<void> getFirebaseMessagingToken(String email) async {
  //   try {
  //     // Request permission for receiving push notifications
  //     await FirebaseMessaging.instance.requestPermission();

  //     // Set notification presentation options for the foreground
  //     await FirebaseMessaging.instance
  //         .setForegroundNotificationPresentationOptions(
  //       alert: true,
  //       badge: true,
  //       sound: true,
  //     );

  //     // Get the FCM token
  //     String? token = await FirebaseMessaging.instance.getToken();

  //     if (token != null) {
  //       // Token retrieval successful, add to notification list
  //       print('FCM Token: $token');
  //       notification.add({
  //         'token': token,
  //         'email': email,
  //         'name': getNameFromEmail(email),
  //       });
  //     } else {
  //       // Token is null, handle this case (perhaps show a message to the user)
  //       print('FCM Token is null');
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during the process
  //     print('Error getting FCM token: $e');
  //     // You might want to show a user-friendly message here
  //     // or log the error to a crash reporting service.
  //   }
  // }
  Future<void> sendPushNotification() async {
    String token =
        "ehjzHqsiRaeNftkeYdB1XR:APA91bFxXrm2rzMw_4E8AqUdfbTGDy7b9h-0-Yzl4btXFkkTzRoKAMpvEZUaFxMPAE0KWhyPGs_sSpejgz4zz_a58E8xR2Ca4f5JsLZSOD0Uw96tuAolT0qr9U5MFGe4FtINteYaWQ3f";

    try {
      final response = await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader:
              'Key=AAAAn9tZv8U:APA91bFiPSZaVkm2KygNE3RIpBcgtqdhCIKPmGbhyE-AIJvTmWXQ8YHdIHcY7iuyEPmjutxMrds5sJ32yHNE83vtR4SxuvEyr7I1KEZ0HoWW_sBujurPt7P1k-KwWhQe5XA8gtyHRs0H'
        },
        body: jsonEncode({
          'to': token,
          'notification': {
            'title': 'New Message',
            'body': 'You have a new message',
            'sound': 'default',
          },
        }),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully to $email');
      } else {
        print(
            'Failed to send notification to $email. Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending push notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = reseve; // assuming reseve is the user's email
    String? userName = getNameFromEmail(userEmail);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName != "Unknown User"
              ? " $userName"
              : "No name available for $userEmail",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _auth.signOut().whenComplete(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              });
            },
            child: const Icon(
              IconData(0xe3b3, fontFamily: 'MaterialIcons'),
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.79,
              child: Messages(
                email: email,
                reseve: reseve,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: message,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 128, 234, 246),
                      hintText: 'message',
                      enabled: true,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 8.0, top: 8.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: new BorderSide(
                            color: Color.fromARGB(255, 93, 197, 246)),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Color.fromARGB(255, 93, 197, 246)),
                        borderRadius: new BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {},
                    onSaved: (value) {
                      message.text = value!;
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('Messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        'email': email,
                        'reseve': reseve,
                      });
                      sendPushNotification();

                      message.clear();
                    }
                  },
                  icon: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
