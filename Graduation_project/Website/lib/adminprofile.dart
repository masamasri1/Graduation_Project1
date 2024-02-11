import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/admincraftmen.dart';
import 'package:flutter_responsive/adminrequest.dart';
import 'package:flutter_responsive/adminstatic.dart';
import 'package:flutter_responsive/adminuser.dart';
import 'package:flutter_responsive/class/Crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_responsive/main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connection/connect.dart';

// ignore: camel_case_types02
class admindashhh extends StatefulWidget {
  final String email;
  const admindashhh({Key? key, required this.email}) : super(key: key);

  @override
  State<admindashhh> createState() => _admindashhhState();
}

// ignore: camel_case_types
class _admindashhhState extends State<admindashhh> {
  TextEditingController name = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController phone = TextEditingController();

  bool isExpanded = false;
  int _selecteIndex = 0;
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _craftmenData = [];
  List<Map<String, dynamic>> _resData = [];
  late final List<Widget> _pages;
  String avatarPhoto = "";

  @override
  void initState() {
    super.initState();
    _pages = [
      admindashhh(email: widget.email),
      admindash(email: widget.email),
      admindashh(email: widget.email),
      admindashhhh(email: widget.email),
      adminstatic(email: widget.email),
    ];
    fetchData();
    userData();
    craftmenData();
    ReservationData();
  }

  Future<void> fetchData() async {
    String email = widget.email;

    try {
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
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    }
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

  void handleEdit(Map<String, dynamic> user) async {
    try {
      final response = await http.post(
        Uri.parse(applink.editadmin),
        body: {
          'admin_id': user['admin_id'].toString(),
          'admin_name': name.text,
          'admin_gmail': gmail.text,
          'admin_phone': phone.text,
          'admin_pass': pass.text,
          'admin_cpass': cpass.text,
        },
      );
      if (response.statusCode == 200) {
        // Successful update
        print("admin updated successfully");
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

  Future<void> pickAndUploadPhoto() async {
    try {
      FilePickerResult? result;
      if (kIsWeb) {
        result = await FilePickerWeb.platform.pickFiles();
      } else {
        result = await FilePicker.platform.pickFiles();
      }

      if (result != null) {
        Uint8List photoBytes = result.files.first.bytes!;
        await uploadPhoto(photoBytes);
        setState(() {
          avatarPhoto = "data:image/png;base64,${base64Encode(photoBytes)}";
        });
      }
    } catch (e) {
      print('Error picking or uploading photo: $e');
    }
  }

  Future<void> uploadPhoto(Uint8List photoBytes) async {
    // Convert bytes to base64 to send in the request
    String base64Photo = base64Encode(photoBytes);

    Map<String, dynamic> photoData = {
      'admin_gmail': widget.email,
      'aphoto': base64Photo,
    };

    try {
      var response = await http.post(
        Uri.parse(applink.aphoto),
        body: photoData,
      );
      if (response.statusCode == 200) {
        // Update the local avatarPhoto with the new photo URL
        setState(() {
          avatarPhoto = json.decode(response.body)['aphoto'];
        });
        print("Photo uploaded successfully");
      } else {
        print("Error uploading photo: ${response.statusCode}");
      }
    } catch (error) {
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
    List uname = _userData
        // .where((map) => map['admin_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List rname = _resData
        // .where((map) => map['admin_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List cname = _craftmenData
        //  .where((map) => map['admin_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List pname = _adminData
        .where((map) => map['admin_gmail'] == email)
        .map((map) => map['admin_name'])
        .toList();

    int u = uname.length;
    int c = cname.length;
    int p = pname.length;
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
              // selectedIndex: _selecteIndex,
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
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                              TextButton.icon(
                                onPressed: () async {
                                  await pickAndUploadPhoto();
                                },
                                icon: Icon(Icons.camera),
                                label: Text("Change Photo"),
                              ),
                            ],
                          ),
                        ),
                        // const Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     CircleAvatar(
                        //       backgroundColor:
                        //           Color.fromARGB(255, 255, 255, 255),
                        //       backgroundImage: AssetImage("img/ll.png"),
                        //       radius: 50.0,
                        //     ),
                        //   ],
                        // ),
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
                            _adminData
                                .where((map) => map['admin_gmail'] == email)
                                .map((user) {
                              name.text = user['admin_name'];
                              gmail.text = user['admin_gmail'];
                              phone.text = user['admin_phone'];
                              pass.text = user['admin_pass'];
                              cpass.text = user['admin_cpass'];
                            }).toList();
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      actions: [
                                        Title(
                                            color: Colors.black,
                                            child: const Row(
                                              children: [
                                                Text("Edit Profile",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        fontSize: 22)),
                                              ],
                                            )),
                                        const SizedBox(
                                          width: 20,
                                          // height: 20,
                                        ),
                                        TextFormField(
                                          controller: name,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Name",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: gmail,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Gmail",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: phone,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Phone Number",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: pass,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Password",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: cpass,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Conform Password",
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7))),
                                            onPressed: () {
                                              _adminData
                                                  .where((map) =>
                                                      map['admin_gmail'] ==
                                                      email)
                                                  .map((user) {
                                                user['admin_name'] = name.text;
                                                user['admin_gmail'] =
                                                    gmail.text;
                                                user['admin_phone'] =
                                                    phone.text;
                                                user['admin_pass'] = pass.text;
                                                user['admin_cpass'] =
                                                    cpass.text;
                                                handleEdit(user);
                                                fetchData();
                                              }).toList();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Edit"))
                                      ],
                                    ));
                          },
                          child: const Icon(
                            IconData(0xe21a, fontFamily: 'MaterialIcons'),
                            color: Color.fromARGB(255, 0, 0, 0),
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

                    const SizedBox(
                      height: 20.0,
                    ),
                    //Now let's start with the dashboard main rapports
                    Center(
                      child: Row(
                        children: [
                          const Flexible(
                              child: SizedBox(
                            width: 300,
                            height: 300,
                          )),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(40.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _adminData
                                      .where(
                                          (map) => map['admin_gmail'] == email)
                                      .map((user) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Name: ${user['admin_name']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Gmail: ${user['admin_gmail']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Phone Number: ${user['admin_phone']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Password: ${user['admin_pass']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                          const Flexible(
                              child: SizedBox(
                            width: 50,
                            height: 50,
                          )),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(40.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                          ),
                        ],
                      ),
                    ),
                    //  Now let's set the article section
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
