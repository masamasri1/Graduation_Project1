import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_responsive/main.dart';
import 'package:flutter_responsive/workercraftmen.dart';
import 'package:flutter_responsive/workerprofile.dart';
import 'package:flutter_responsive/workerrequest.dart';
import 'package:flutter_responsive/workeruser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connection/connect.dart';
import 'package:charts_flutter/flutter.dart' as charts;

// ignore: camel_case_types
class Workerstatic extends StatefulWidget {
  final String email;
  const Workerstatic({Key? key, required this.email}) : super(key: key);

  @override
  State<Workerstatic> createState() => _WorkerstaticState();
}

// ignore: camel_case_types
class _WorkerstaticState extends State<Workerstatic> {
  List<Map<String, dynamic>> _craftmenData = [];
  List<Map<String, dynamic>> _resData = [];
  List<Map<String, dynamic>> _userData = [];
  List<UserRate> _rateData = [];
  bool isExpanded = false;
  int _selecteIndex = 4;
  late final List<Widget> _pages;
  String avatarPhoto = "";
  @override
  void initState() {
    super.initState();
    userData();
    craftmenData();
    ReservationData();
    RatingData();
    // print("kkkk");
    _pages = [
      profile(email: widget.email),
      workeruser(email: widget.email),
      workercraftmen(email: widget.email),
      WorkerRequest(email: widget.email),
      Workerstatic(email: widget.email),
    ];
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

  Future<void> craftmenData() async {
    String email = widget.email;
    try {
      var response = await http.post(Uri.parse(applink.showcraftmen));
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          setState(() {
            _craftmenData =
                List<Map<String, dynamic>>.from(responseData['data']);
            String avatarPhotobit = _craftmenData
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
    } catch (error) {
      // Handle other errors
      print('Error: $error');
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

  Future<void> RatingData() async {
    String email = widget.email;
    try {
      var response = await http
          .post(Uri.parse("http://localhost:8000/ONDUTY/user/showrate.php"));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');

        if (responseData['status'] == 'success') {
          setState(() {
            _rateData = (responseData['data'] as List<dynamic>)
                .where((map) => map['craftmen_gmail'] == email)
                .map((item) => UserRate.fromJson(item))
                .toList();
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

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    List pname = _craftmenData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List uname = _userData
        //  .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List rname = _resData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    double u = uname.length as double;
    double r = rname.length as double;
    u = (u * 100) / 100;
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 200, // Adjust the height as needed
                                width: 400,
                                child: PieChart(
                                  PieChartData(
                                    sections: [
                                      PieChartSectionData(
                                        color: Colors.blue,
                                        value: u,
                                        title: '$u% ',
                                        radius: 60,
                                        titleStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      PieChartSectionData(
                                        color:
                                            Color.fromARGB(255, 142, 165, 176),
                                        value: r,
                                        title: '$r% ',
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
                                  "Between User that using the app and My Reservation"),
                              const Text("Blue: user"),
                              const Text("Gray : My Reservation")
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            _rateData.isEmpty
                                ? Text(
                                    "No Rating Until Now") //CircularProgressIndicator()
                                : BarChart(_rateData),
                            const Text(
                                "Between User and their rating after i finished my work"),
                            const SizedBox(
                              height: 20,
                            )
                            // Add other widgets or charts here if needed
                          ],
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

class BarChart extends StatelessWidget {
  final List<UserRate> data;

  BarChart(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400, // Specify the width as needed
      height: 300, // Specify the height as needed
      child: charts.BarChart(
        [
          charts.Series<UserRate, String>(
            id: '1',
            domainFn: (item, _) => item.userName,
            measureFn: (item, _) => item.rating,
            data: data,
          ),
        ],
        animate: true,
      ),
    );
  }
}

class UserRate {
  final String userName;
  // final int userRate;
  final int rating;

  UserRate(this.userName, this.rating);

  factory UserRate.fromJson(Map<String, dynamic> json) {
    return UserRate(
      json['user_name'],
      int.parse(json['rating']),
    );
  }
}
