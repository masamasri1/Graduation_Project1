import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_responsive/ChatScreen.dart';
import 'package:flutter_responsive/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_responsive/admincraftmen.dart';
import 'package:flutter_responsive/adminprofile.dart';
import 'package:flutter_responsive/adminrequest.dart';
import 'package:flutter_responsive/adminstatic.dart';
import 'package:flutter_responsive/class/Crud.dart';
import 'connection/connect.dart';

// ignore: camel_case_types
class admindash extends StatefulWidget {
  final String email;
  const admindash({Key? key, required this.email}) : super(key: key);

  @override
  State<admindash> createState() => _admindashState();
}

// ignore: camel_case_types
class _admindashState extends State<admindash> {
  // ignore: prefer_final_fields
  Crud _crud = Crud();
  // ignore: non_constant_identifier_names
  TextEditingController user_name = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController un = TextEditingController();
  TextEditingController ugmail = TextEditingController();
  TextEditingController upass = TextEditingController();
  TextEditingController ucpass = TextEditingController();
  TextEditingController uphone = TextEditingController();
  TextEditingController ucity = TextEditingController();
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _craftmenData = [];
  List<Map<String, dynamic>> _resData = [];
  bool isExpanded = false;
  int _selecteIndex = 1;
  late final List<Widget> _pages;
  String avatarPhoto = "";

  @override
  void initState() {
    super.initState();
    // print("kkkk");
    _pages = [
      admindashhh(email: widget.email),
      admindash(email: widget.email),
      admindashh(email: widget.email),
      admindashhhh(email: widget.email),
      adminstatic(email: widget.email),
    ];
    fetchData();
    craftmenData();
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

  // final List<Widget> _pages = [
  //   admindashhh(
  //     email: '',
  //   ),
  //   admindash(),
  //   admindashh(),
  //   admindashhhh(),
  //   adminstatic(),
  // ];

  Future<void> adduser() async {
    try {
      var response = await _crud.postRequest(applink.adduser, {
        'user_name': user_name.text,
        'gmail': gmail.text,
        'phone_number': phone.text,
        'password': pass.text,
        'cpassword': cpass.text,
        'city': city.text,
      });

      if (response['status'] == "success") {
        print("User added successfully");
      } else {
        print("Failed to add user");
      }
    } catch (e) {
      print("Error: $e");
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

  Future<void> searchbyname(String userName) async {
    var response = await http
        .post(Uri.parse(applink.search), body: {'user_name': userName});
    // print(response.toString());
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

  void handleDelete(int userId) async {
    try {
      var response = await http.post(Uri.parse(applink.delete),
          body: {'user_id': userId.toString()});

      if (response.statusCode == 200) {
        // Successful deletion
        print("User deleted successfully");
        fetchData(); // Implement a function to fetch updated user data
      } else {
        // Handle error
        print("Failed to delete user: ${response.reasonPhrase}");
        // Optionally, show a snackbar or dialog to inform the user about the error
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      // Optionally, show a snackbar or dialog to inform the user about the error
    }
  }

  void handleEdit(Map<String, dynamic> user) async {
    try {
      final response = await http.post(
        Uri.parse(applink.edit),
        body: {
          'user_id': user['user_id'].toString(),
          'user_name': un.text,
          'gmail': ugmail.text,
          'phone_number': uphone.text,
          'password': upass.text,
          'cpassword': ucpass.text,
          'city': ucity.text,
        },
      );
      print(user['user_id'].toString());
      if (response.statusCode == 200) {
        // Successful update
        print("User updated successfully");
        fetchData();
      } else {
        // Handle error
        print("Failed to update user: ${response.reasonPhrase}");
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
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
    int u = uname.length;
    int c = cname.length;
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
                    // const Row(
                    //   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Flexible(
                    //       child: Card(
                    //         child: Padding(
                    //           padding: EdgeInsets.all(18.0),
                    //           child: Column(
                    //             crossAxisAlignment: CrossAxisAlignment.start,
                    //             children: [
                    //               Row(
                    //                 children: [
                    //                   Image(
                    //                     image: AssetImage("img/ll.png"),
                    //                     width: 120,
                    //                     height: 120,
                    //                   ),
                    //                   SizedBox(
                    //                     width: 15.0,
                    //                   ),
                    //                 ],
                    //               ),
                    //               SizedBox(
                    //                 height: 20.0,
                    //               ),
                    //               Text(
                    //                 " Application that helps connect users with technical workers. \n Make it easier for users to have home services.\n Providing many job opportunities for Palestinian youth and technical workers.",
                    //                 style: TextStyle(
                    //                   fontSize: 20,
                    //                   //fontWeight: FontWeight.bold,
                    //                   fontStyle: FontStyle.italic,
                    //                 ),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // //  Now let's set the article section
                    // const SizedBox(
                    //   height: 30.0,
                    // ),
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
                                    hintText: "Search here by name",
                                  ),
                                ),
                              ),
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
                            DataColumn(label: Text(" city")),
                            DataColumn(label: Text(" Delete")),
                            DataColumn(label: Text(" Edit")),
                            DataColumn(label: Text(" Massage")),
                          ],
                          rows: _userData.map((user) {
                            return DataRow(cells: [
                              DataCell(Text(user['user_name'])),
                              DataCell(Text(user['gmail'])),
                              DataCell(Text(user['phone_number'])),
                              DataCell(Text(user['city'])),
                              DataCell(TextButton(
                                onPressed: () {
                                  handleDelete(user['user_id']);
                                },
                                child: const Icon(
                                  IconData(0xe1b9, fontFamily: 'MaterialIcons'),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                              DataCell(TextButton(
                                onPressed: () {
                                  un.text = user['user_name'];
                                  ugmail.text = user['gmail'];
                                  uphone.text = user['phone_number'];
                                  upass.text = user['password'];
                                  ucpass.text = user['cpassword'];
                                  ucity.text = user['city'];
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              Row(
                                                children: [
                                                  Title(
                                                      color: Colors.black,
                                                      child: const Text(
                                                          "Edit User",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(255,
                                                                      0, 0, 0),
                                                              fontSize: 22))),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                                // height: 20,
                                              ),
                                              TextFormField(
                                                controller: un,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Username",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ugmail,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Gmail",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: uphone,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Phone Number",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: upass,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Password",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ucpass,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "CPassword",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ucity,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "City",
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      minimumSize:
                                                          const Size(240, 50),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7))),
                                                  onPressed: () {
                                                    // Call the function to handle edit
                                                    handleEdit(user);
                                                    print(user);
                                                    // Clear the text controllers
                                                    un.clear();
                                                    ugmail.clear();
                                                    upass.clear();
                                                    ucpass.clear();
                                                    uphone.clear();
                                                    ucity.clear();
                                                    // Close the dialog
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Submit"))
                                            ],
                                          ));
                                },
                                child: const Icon(
                                  IconData(0xe21a, fontFamily: 'MaterialIcons'),
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
                                                reseve: user['gmail'],
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
                        //Now let's set the pagination
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
                                          Text(
                                            "Number of Craftment: $c",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actions: [
                      Title(
                          color: Colors.black,
                          child: const Text("Add User",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 22))),
                      const SizedBox(
                        width: 20,
                        // height: 20,
                      ),
                      TextFormField(
                        controller: user_name,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Username",
                        ),
                      ),
                      TextFormField(
                        controller: gmail,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Gmail",
                        ),
                      ),
                      TextFormField(
                        controller: phone,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Phone Number",
                        ),
                      ),
                      TextFormField(
                        controller: pass,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Password",
                        ),
                      ),
                      TextFormField(
                        controller: cpass,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "CPassword",
                        ),
                      ),
                      TextFormField(
                        controller: city,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "City",
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              minimumSize: const Size(240, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7))),
                          onPressed: () {
                            adduser();
                            user_name.clear();
                            gmail.clear();
                            pass.clear();
                            cpass.clear();
                            phone.clear();
                            city.clear();
                            fetchData();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Submit"))
                    ],
                  ));
        },
        backgroundColor: const Color.fromARGB(255, 76, 155, 207),
        child: const Icon(Icons.add),
      ),
    );
    // ignore: dead_code
  }
}
