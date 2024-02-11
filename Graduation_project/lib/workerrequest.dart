import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_responsive/main.dart';
import 'package:flutter_responsive/workercraftmen.dart';
import 'package:flutter_responsive/workerprofile.dart';
import 'package:flutter_responsive/workerstatic.dart';
import 'package:flutter_responsive/workeruser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connection/connect.dart';

// ignore: camel_case_types
class WorkerRequest extends StatefulWidget {
  final String email;
  const WorkerRequest({Key? key, required this.email}) : super(key: key);

  @override
  State<WorkerRequest> createState() => _WorkerRequestState();
}

// ignore: camel_case_types
class _WorkerRequestState extends State<WorkerRequest> {
  List<Map<String, dynamic>> _craftmenData = [];
  List<Map<String, dynamic>> _resData = [];
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _userData = [];
  TextEditingController search = TextEditingController();

  bool isExpanded = false;
  bool showInfoBox = false;
  String avatarPhoto = "";
  int _selecteIndex = 3;
  late final List<Widget> _pages;
  @override
  void initState() {
    super.initState();
    craftmenData();
    adminData();
    userData();
    ReservationData();

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

  void handleshowinfo(Map<String, dynamic> user, bool showInfoBox) {
    if (showInfoBox) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Card(
              key: ValueKey(user['res_id'].toString()),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("StartDate: ${user['start_date']}"),
                  Text("EndDate: ${user['end_date']}"),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  Future<void> deleteReservation(String resId) async {
    try {
      var response = await http.post(
        Uri.parse(applink.rdelete),
        body: {'res_id': resId},
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print("Reservation deleted successfully");
        ReservationData(); // Implement a function to fetch updated reservation data
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

  List<Map<String, dynamic>> _originalUserData = [];
  Future<void> searchBy(String query) async {
    List<Map<String, dynamic>> filteredData;

    if (_originalUserData.isEmpty) {
      _originalUserData = List.from(_resData);
    }

    if (query.isEmpty) {
      filteredData = List.from(_originalUserData);
    } else {
      filteredData = _originalUserData.where((row) {
        for (var value in row.values) {
          if (value.toString().toLowerCase().contains(query.toLowerCase())) {
            return true;
          }
        }
        return false;
      }).toList();
    }

    setState(() {
      _resData = filteredData;
    });
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    List pname = _craftmenData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List uname = _userData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List rname = _resData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    int u = uname.length;
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
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 200,
                              child: Expanded(
                                child: TextFormField(
                                  controller: search,
                                  decoration: const InputDecoration(
                                    hintText: "Search here",
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    searchBy(search.text);
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
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        DataTable(
                          // ignore: prefer_const_literals_to_create_immutables
                          columns: [
                            // DataColumn(label: Text('Reservation ID')),
                            // const DataColumn(label: Text('Craftsman Name')),
                            const DataColumn(label: Text('User Name')),
                            const DataColumn(label: Text('Service Name')),
                            const DataColumn(label: Text('Start Date')),
                            const DataColumn(label: Text('End Date')),
                            const DataColumn(label: Text('Delete')),
                            //  const DataColumn(label: Text('Reservation Info')),

                            // Add other columns as needed
                          ],
                          rows: _resData
                              .where((map) => map['craftmen_gmail'] == email)
                              .map((row) {
                            return DataRow(
                              cells: [
                                //  DataCell(Text('${row['res_id']}')),
                                //  DataCell(Text('${row['craftmen_user_name']}')),
                                DataCell(Text('${row['users_user_name']}')),
                                DataCell(Text('${row['job']}')),
                                DataCell(Text('${row['end_date']}')),
                                DataCell(Text('${row['start_date']}')),
                                DataCell(TextButton(
                                  onPressed: () {
                                    deleteReservation(row['res_id']);
                                  },
                                  child: const Icon(
                                    IconData(0xe1b9,
                                        fontFamily: 'MaterialIcons'),
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                )),
                                // DataCell(TextButton(
                                //   //  key: _key ,
                                //   onPressed: () {
                                //     setState(() {
                                //       showInfoBox = !showInfoBox;
                                //       // selectedUserId = user['user_id'].toString();
                                //       handleshowinfo(row, showInfoBox);
                                //     });
                                //   },
                                //   child: const Icon(
                                //     IconData(0xe33c,
                                //         fontFamily: 'MaterialIcons'),
                                //     color: Color.fromARGB(255, 0, 0, 0),
                                //   ),
                                // )),

                                // Add other cells as needed
                              ],
                            );
                          }).toList(),
                        ),
                        //Now let's set the pagination
                        const SizedBox(
                          width: 40,
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
