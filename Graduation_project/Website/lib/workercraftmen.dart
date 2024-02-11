import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_responsive/ChatScreen.dart';
import 'package:flutter_responsive/main.dart';
import 'package:flutter_responsive/workerprofile.dart';
import 'package:flutter_responsive/workerrequest.dart';
import 'package:flutter_responsive/workerstatic.dart';
import 'package:flutter_responsive/workeruser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'connection/connect.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class Job {
  int jobId;
  String jobName;

  Job({required this.jobId, required this.jobName});
}

// ignore: camel_case_types
class workercraftmen extends StatefulWidget {
  final String email;
  const workercraftmen({Key? key, required this.email}) : super(key: key);

  @override
  State<workercraftmen> createState() => _workercraftmenState();
}

// ignore: camel_case_types
class _workercraftmenState extends State<workercraftmen> {
  List<Map<String, dynamic>> _usercraftmen = [];
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _resData = [];
  TextEditingController search = TextEditingController();
  String avatarPhoto = "";

  bool showInfoBox = false;
  //Map<String, bool> showInfoBox = {};
  String? selectedUserId;

  late final List<Widget> _pages;
  bool isExpanded = false;
  int _selecteIndex = 2;

  @override
  void initState() {
    super.initState();
    // print("kkkk");
    _pages = [
      profile(email: widget.email),
      workeruser(email: widget.email),
      workercraftmen(email: widget.email),
      WorkerRequest(email: widget.email),
      Workerstatic(email: widget.email),
    ];
    fetchData();
    userData();
    adminData();
    ReservationData();
  }

  Future<void> ReservationData() async {
    try {
      var response = await http.post(Uri.parse(applink.showrequest));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');

        if (responseData['status'] == 'success') {
          setState(() {
            _resData = List<Map<String, dynamic>>.from(responseData['data']);
            print('_resData: $_resData');
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

  void handleshowinfo(Map<String, dynamic> user, bool showInfoBox) {
    if (showInfoBox) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Card(
              key: ValueKey(user['user_id'].toString()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Gender: ${user['gender']}"),
                  Text("Job: ${user['job']}"),
                  Text("Price: ${user['price']}"),
                  Text("Emergency: ${user['emergency']}"),
                  Text("City: ${user['craftmen_city']}"),
                  Text("Working Day: ${user['working_day']}"),
                  // Add any additional widgets or buttons here
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> fetchData() async {
    String email = widget.email;
    var response = await http.post(Uri.parse(applink.showcraftmen));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          _usercraftmen = List<Map<String, dynamic>>.from(responseData['data']);
          String avatarPhotobit = _usercraftmen
              .where((map) => map['craftmen_gmail'] == email)
              .map((user) => user['aphoto'])
              .first;
          if (avatarPhotobit.isNotEmpty)
            avatarPhoto = "data:image/png;base64,$avatarPhotobit";
          else {
            avatarPhoto = '';
          }
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

  Uint8List _decodeBase64(String input) {
    try {
      String base64String = input.split(',').last.replaceAll('\n', '');
      return base64Decode(base64String);
    } catch (e) {
      print('Error decoding base64: $e');
      return Uint8List(0);
    }
  }

  Future<void> userData() async {
    var response = await http.post(Uri.parse(applink.showuserconnect));
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

  Future<void> searchbyname(String userName) async {
    var response = await http
        .post(Uri.parse(applink.csearch), body: {'user_name': userName});
    // print(response.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          _usercraftmen = List<Map<String, dynamic>>.from(responseData['data']);
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

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    List pname = _usercraftmen
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    //List name = _usercraftmen.map((map) => map['user_name']).toList();
    List uname = _userData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List rname = _resData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();

    int u = uname.length;
    // int c = name.length;
    int r = rname.length;
    return Scaffold(
      body: Row(
        children: [
          //Let's start by adding the Navigation Rail
          NavigationRail(
              onDestinationSelected: (int index) {
                setState(() {
                  _selecteIndex = index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _pages[index]),
                  );
                });
              },
              extended: isExpanded,
              backgroundColor: const Color.fromARGB(255, 76, 155, 207),
              unselectedIconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 0, 0, 0), opacity: 1),
              unselectedLabelTextStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              selectedLabelTextStyle: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              selectedIconTheme:
                  const IconThemeData(color: Color.fromARGB(255, 70, 200, 236)),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.account_circle),
                  label: Text("profile"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_2),
                  label: Text("Users"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.person_3),
                  label: Text("Craftmens"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.assignment_add),
                  label: Text("Reservation"),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bar_chart),
                  label: Text("Rapports"),
                ),
              ],
              selectedIndex: _selecteIndex),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //let's add the navigation menu for this project
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            //let's trigger the navigation expansion
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          icon: const Icon(Icons.menu),
                        ),
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: avatarPhoto.isNotEmpty
                                  ? Image.memory(
                                      _decodeBase64(avatarPhoto),
                                      width: 120,
                                      height: 120,
                                    )
                                  : Image.asset(
                                      "img/profile.jpg",
                                      width: 120,
                                      height: 120,
                                    ),
                            ),
                            Text(
                              pname.isNotEmpty
                                  ? " ${pname.join(", ")}"
                                  : "No names available for $email",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()));
                              },
                              child: const Icon(
                                IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    //Now let's start with the dashboard main rapports
                    const Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage("img/ll.png"),
                                        width: 120,
                                        height: 120,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                  Text(
                                    " Application that helps connect users with technical workers. \n Make it easier for users to have home services.\n Providing many job opportunities for Palestinian youth and technical workers.",
                                    style: TextStyle(
                                      fontSize: 20,
                                      //fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //  Now let's set the article section
                    const SizedBox(
                      height: 30.0,
                    ),

                    Row(
                      //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              //child: Expanded(
                              child: TextFormField(
                                controller: search,
                                decoration: const InputDecoration(
                                  hintText: "Search here by name",
                                ),
                              ),
                              //  ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchbyname(search.text);
                                    print(search.text);
                                  });
                                },
                                icon: const Icon(Icons.search)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DataTable(
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => Colors.grey.shade200),
                          columns: const [
                            DataColumn(label: Text(" Name")),
                            DataColumn(label: Text(" Gmail")),
                            DataColumn(label: Text(" Phone number")),
                            DataColumn(label: Text(" Info")),
                            DataColumn(label: Text(" Massege")),
                          ],
                          rows: _usercraftmen.map((user) {
                            return DataRow(cells: [
                              DataCell(Text(user['user_name'])),
                              DataCell(Text(user['craftmen_gmail'])),
                              DataCell(Text(user['craftmen_phone'])),
                              //  DataCell(Text(user['craftmen_city'])),
                              DataCell(TextButton(
                                //  key: _key ,
                                onPressed: () {
                                  setState(() {
                                    showInfoBox = !showInfoBox;
                                    // selectedUserId = user['user_id'].toString();
                                    handleshowinfo(user, showInfoBox);
                                  });
                                },
                                child: const Icon(
                                  IconData(0xe33c, fontFamily: 'MaterialIcons'),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                              DataCell(TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => chatpage(
                                                email: email,
                                                reseve: user['craftmen_gmail'],
                                              )));
                                  setState(() {});
                                },
                                child: const Icon(
                                  IconData(0xe3e0, fontFamily: 'MaterialIcons'),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                            ]);
                          }).toList(),
                        ),
                        const SizedBox(
                          width: 50.0,
                        ),
                        Flexible(
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(40.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Number of Users: $u",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          // Text(
                                          //   "Number of Craftment: $c",
                                          //   style: TextStyle(fontSize: 15),
                                          // ),
                                          Text(
                                            "Number of Reservation: $r",
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      //let's add the floating action button
    );
    // ignore: dead_code
  }
}
