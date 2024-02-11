import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'connection/connect.dart';
import 'package:graduation_project/link.dart';

class Messages extends StatefulWidget {
  final String email;
  final String reseve;
  String namesender;
  String nameres;

  Messages(
      {required this.email,
      required this.reseve,
      required this.namesender,
      required this.nameres});

  @override
  _MessagesState createState() => _MessagesState(email: email, reseve: reseve);
}

class _MessagesState extends State<Messages> {
  List<Map<String, dynamic>> _userData = [];
  //List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _craftmenData = [];
  String email;
  String reseve;
  late Stream<QuerySnapshot> _messageStream;

  _MessagesState({required this.email, required this.reseve});

  @override
  void initState() {
    super.initState();
    setupData();

    _messageStream = FirebaseFirestore.instance
        .collection('Messages')
        .orderBy('time')
        .snapshots();
  }

  Future<void> setupData() async {
    //  await fetchData();
    // await craftmenData();
    //ظawait adminData();
  }

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

  @override
  Widget build(BuildContext context) {
    String userEmail = reseve; // assuming reseve is the user's email
    String? userName = widget.nameres;
    return StreamBuilder(
      stream: _messageStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Error: ${snapshot.error}");
          return Text("Error: ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemBuilder: (_, index) {
            QueryDocumentSnapshot qs = snapshot.data!.docs[index];
            Timestamp t = qs['time'];
            DateTime d = t.toDate();
            print(d.toString());

            // Check if the message is intended for the current user
            bool isCurrentUser = email == qs['email'];
            bool isCurrentReseve = reseve == qs['reseve'];
            bool isCurrentUser1 = email == qs['reseve'];
            bool isCurrentReseve1 = reseve == qs['email'];

            if ((isCurrentUser && isCurrentReseve) ||
                (isCurrentUser1 && isCurrentReseve1)) {
              return Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Column(
                  crossAxisAlignment: isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 300,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.purple,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        title: Text(
                          isCurrentUser
                              ? "You"
                              : userName ??
                                  "Unknown User", // Show "You" for current user
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                qs['message'],
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Text(
                              "${d.hour}:${d.minute}",
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              // Message not intended for the current user, so don't display it
              return Container();
            }
          },
        );
      },
    );
  }
}
