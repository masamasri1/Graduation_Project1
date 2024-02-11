import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_responsive/main.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_responsive/admincraftmen.dart';
import 'package:flutter_responsive/adminprofile.dart';
import 'package:flutter_responsive/adminrequest.dart';
import 'package:flutter_responsive/adminuser.dart';
import 'connection/connect.dart';

// ignore: camel_case_types
class adminstatic extends StatefulWidget {
  final String email;
  const adminstatic({Key? key, required this.email}) : super(key: key);

  @override
  State<adminstatic> createState() => _adminstaticState();
}

// ignore: camel_case_types
class _adminstaticState extends State<adminstatic> {
  bool isExpanded = false;
  int _selecteIndex = 4;
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _resData = [];
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _craftmenData = [];
  String avatarPhoto = "";

  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    adminData();
    userData();
    craftmenData();
    ReservationData();

    _pages = [
      admindashhh(email: widget.email),
      admindash(email: widget.email),
      admindashh(email: widget.email),
      admindashhhh(email: widget.email),
      adminstatic(email: widget.email),
    ];
  }

  Future<void> userData() async {
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

  Future<void> adminData() async {
    String email = widget.email;
    var response = await http.post(Uri.parse(applink.showadmin));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          _adminData = List<Map<String, dynamic>>.from(responseData['data']);
          String avatarPhotobit = _adminData
              .where((map) => map['admin_gmail'] == email)
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

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    List pname = _adminData
        .where((map) => map['admin_gmail'] == email)
        .map((map) => map['admin_name'])
        .toList();
    List uname = _userData.map((map) => map['user_name']).toList();
    List cname = _craftmenData.map((map) => map['user_name']).toList();
    List rname = _resData.map((map) => map['user_name']).toList();
    double u = uname.length as double;
    double c = cname.length as double;
    double r = rname.length as double;
    u = (u * 100) / 100;
    c = (c * 100) / 100;
    r = (r * 100) / 100;
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
                            Row(
                              children: [
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
                                            builder: (context) => MyApp()));
                                  },
                                  child: const Icon(
                                    IconData(0xe3b3,
                                        fontFamily: 'MaterialIcons'),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200, // Adjust the height as needed
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: Colors.blue,
                                      value: u,
                                      title: ' User : $u% ',
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: Color.fromARGB(255, 142, 165, 176),
                                      value: c,
                                      title: ' Craftmen : $c% ',
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    // Add more sections as needed
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            const Text(" Between Number User and Craftmen"),
                            const SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            SizedBox(
                              height: 200, // Adjust the height as needed
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: Colors.blue,
                                      value: u,
                                      title: ' User : $u% ',
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: Color.fromARGB(255, 142, 165, 176),
                                      value: r,
                                      title: ' Reservation: $r% ',
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            const Text(
                                " Between Number of User and Reservation"),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                          //   width: 80,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
