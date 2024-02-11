import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/messge.dart';
//import 'package:flutter_responsive/admincraftmen.dart';
//import 'package:flutter_responsive/adminuser.dart';
//import 'package:flutter_responsive/main.dart';
//import 'package:flutter_responsive/massag.dart';
import 'package:http/http.dart' as http;
//import 'connection/connect.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/link.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

class chatpage extends StatefulWidget {
  String email;
  String reseve;
  String namesender;
  String nameres;
  chatpage(
      {super.key,
      required this.email,
      required this.reseve,
      required this.namesender,
      required this.nameres});
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

  // Future<void> adminData() async {
  //   var response = await http.post(Uri.parse(applink.showadmin));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);

  //     if (responseData['status'] == 'success') {
  //       setState(() {
  //         _adminData = List<Map<String, dynamic>>.from(responseData['data']);
  //       });
  //     } else {
  //       // Handle failure
  //       print('Failed to fetch data: ${responseData['message']}');
  //     }
  //   } else {
  //     // Handle HTTP error
  //     print('HTTP error: ${response.statusCode}');
  //   }
  // }

  // Future<void> fetchData() async {
  //   var response = await http.post(Uri.parse(applink.showuser));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);

  //     if (responseData['status'] == 'success') {
  //       setState(() {
  //         _userData = List<Map<String, dynamic>>.from(responseData['data']);
  //       });
  //     } else {
  //       // Handle failure
  //       print('Failed to fetch data: ${responseData['message']}');
  //     }
  //   } else {
  //     // Handle HTTP error
  //     print('HTTP error: ${response.statusCode}');
  //   }
  // }

  // Future<void> craftmenData() async {
  //   var response = await http.post(Uri.parse(applink.showcraftmen));
  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> responseData = json.decode(response.body);
  //     if (responseData['status'] == 'success') {
  //       setState(() {
  //         _craftmenData = List<Map<String, dynamic>>.from(responseData['data']);
  //       });
  //     } else {
  //       // Handle failure
  //       print('Failed to fetch data: ${responseData['message']}');
  //     }
  //   } else {
  //     // Handle HTTP error
  //     print('HTTP error: ${response.statusCode}');
  //   }
  // }

  void initState() {
    super.initState();
    //fetchData();
    // craftmenData();
    //adminData();
  }

  // String? getNameFromEmail(String email) {
  //   String? name;
  //   // if (_adminData.any((map) => map['admin_gmail'] == email)) {
  //   //   name = _adminData
  //   //       .firstWhere((map) => map['admin_gmail'] == email)['admin_name'];
  //   // } else
  //   if (_userData.any((map) => map['gmail'] == email)) {
  //     name = _userData.firstWhere((map) => map['gmail'] == email)['user_name'];
  //   } else if (_craftmenData.any((map) => map['craftmen_gmail'] == email)) {
  //     name = _craftmenData
  //         .firstWhere((map) => map['craftmen_gmail'] == email)['user_name'];
  //   } else {
  //     // Handle the case when the email is not found in either list
  //     name = null;
  //   }

  //   print(name);
  //   return name;
  // }
  Future<void> sendPushNotification(
      String receiverToken, String message) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        // Remove the 'Authorization' header
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': message,
            'title': 'New Message',
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'message': message,
          },
          'to': receiverToken,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = reseve; // assuming reseve is the user's email
    String? userName = widget.nameres;
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
                namesender: widget.namesender,
                nameres: widget.nameres,
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
                      sendPushNotification(
                          'fEKITGMPSPiGMNl-J0WLYu:APA91bFGl8HeTvWHJWBn-KhLK4qmhY1sYegbHiLlYJYo1P7K_GBsXyUh80GVTIAZKpVKh18zwj49PWsElzUz5ffxhJdmY7OqklU6Fvo-ejxltzBiG4JMr_gT9ItyzVouEmyZflzppAFK',
                          message.text.trim());

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
