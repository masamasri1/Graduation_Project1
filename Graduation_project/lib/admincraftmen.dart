import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_responsive/ChatScreen.dart';
import 'package:flutter_responsive/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_responsive/adminprofile.dart';
import 'package:flutter_responsive/adminrequest.dart';
import 'package:flutter_responsive/adminstatic.dart';
import 'package:flutter_responsive/adminuser.dart';
import 'connection/connect.dart';

//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class Job {
  int jobId;
  String jobName;

  Job({required this.jobId, required this.jobName});
}

// ignore: camel_case_types
class admindashh extends StatefulWidget {
  final String email;
  const admindashh({Key? key, required this.email}) : super(key: key);

  @override
  State<admindashh> createState() => _admindashhState();
}

// ignore: camel_case_types
class _admindashhState extends State<admindashh> {
  List<Map<String, dynamic>> _usercraftmen = [];
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _adminData = [];
  List<Map<String, dynamic>> _resData = [];

  TextEditingController cname = TextEditingController();
  TextEditingController cgmail = TextEditingController();
  TextEditingController cpass = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController cphone = TextEditingController();
  TextEditingController ccity = TextEditingController();
  TextEditingController em = TextEditingController();
  TextEditingController cgender = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController cost = TextEditingController();
  //TextEditingController job = new TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _dateTimeController = TextEditingController();
  TextEditingController ccname = TextEditingController();
  TextEditingController ccgmail = TextEditingController();
  TextEditingController ccpass = TextEditingController();
  TextEditingController cccpass = TextEditingController();
  TextEditingController ccphone = TextEditingController();
  TextEditingController cccity = TextEditingController();
  TextEditingController cem = TextEditingController();
  TextEditingController ccgender = TextEditingController();
  TextEditingController ccost = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _cdateTimeController = TextEditingController();
  // DateTime? _selectedStartDateTime;
  // DateTime? _selectedEndDateTime;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  String avatarPhoto = "";

  bool showInfoBox = false;
  //Map<String, bool> showInfoBox = {};
  String? selectedUserId;

  List<Job> jobs = [
    Job(jobId: 1, jobName: 'Carpenter'),
    Job(jobId: 2, jobName: 'Cleaning'),
    Job(jobId: 3, jobName: 'Driver'),
    Job(jobId: 4, jobName: 'Elecrician'),
    Job(jobId: 5, jobName: 'Gardener'),
    Job(jobId: 6, jobName: 'Painter'),
    Job(jobId: 7, jobName: 'Tailor'),
    Job(jobId: 8, jobName: 'Plumber'),
    Job(jobId: 9, jobName: 'Smith'),
    Job(jobId: 10, jobName: 'Tiler'),
  ];

  Job? selectedJob;
  late final List<Widget> _pages;
  bool isExpanded = false;
  int _selecteIndex = 2;

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

  void handleEdit(Map<String, dynamic> user) async {
    try {
      final response = await http.post(
        Uri.parse(applink.cedit),
        body: {
          'user_id': user['user_id'].toString(),
          'user_name': ccname.text,
          'craftmen_gmail': ccgmail.text,
          'craftmen_phone': ccphone.text,
          'gender': ccgender.text,
          'password': ccpass.text,
          'cpassword': cccpass.text,
          'craftmen_city': cccity.text,
          'jop_id': selectedJob!.jobId.toString(),
          'job': selectedJob!.jobName,
          'price': ccost.text,
          'emergency': cem.text,
          'working_day': _cdateTimeController.text,
        },
      );

      print(
          "Response body: ${response.body}"); // Add this line to print the response

      if (response.statusCode == 200) {
        // Successful update
        print("craftmen updated successfully");
        fetchData();
      } else {
        // Handle error
        print("Failed to update craftmen: ${response.reasonPhrase}");
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
    }
  }

  Future<void> _showDateTimeRangePicker(BuildContext context) async {
    // Select start time
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime != null) {
      // Select end time
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (endTime != null) {
        // Process selected times
        setState(() {
          _selectedStartTime = startTime;
          _selectedEndTime = endTime;
          _updateTextField(_dateTimeController);
          _updateTextField(_cdateTimeController);
        });
      }
    }
  }

  void _updateTextField(TextEditingController controller) {
    // Update the text field based on the selected times
    if (_selectedStartTime != null && _selectedEndTime != null) {
      String startTimeText = _formatTimeOfDay(_selectedStartTime!);
      String endTimeText = _formatTimeOfDay(_selectedEndTime!);

      controller.text = '$startTimeText - $endTimeText';
    } else {
      controller.text = 'Select Start & End Time';
    }
  }

  String _formatTimeOfDay(TimeOfDay timeOfDay) {
    // Format TimeOfDay as HH:mm
    return '${timeOfDay.hourOfPeriod}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }

  void handleDelete(String userId) async {
    try {
      var response = await http.post(Uri.parse(applink.deletecraft),
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

  Future<void> fetchData() async {
    var response = await http.post(Uri.parse(applink.showcraftmen));
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

  Future<void> addcraftmen() async {
    try {
      // Get the ID corresponding to the selected job
      final response = await http.post(
        Uri.parse(applink.addcraftmen),
        body: {
          'user_name': cname.text,
          'craftmen_gmail': cgmail.text,
          'craftmen_phone': cphone.text,
          'gender': cgender.text,
          'password': pass.text,
          'cpassword': cpass.text,
          'craftmen_city': ccity.text,
          'jop_id': selectedJob!.jobId.toString(),
          'job': selectedJob!.jobName,
          'price': cost.text,
          'emergency': em.text,
          'working_day': _dateTimeController.text,
        },
      );
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
    List pname = _adminData
        .where((map) => map['admin_gmail'] == email)
        .map((map) => map['admin_name'])
        .toList();
    List uname = _userData.map((map) => map['user_name']).toList();
    List name = _usercraftmen.map((map) => map['user_name']).toList();
    List rname = _resData.map((map) => map['user_name']).toList();

    int u = uname.length;
    int c = name.length;
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
                // NavigationRailDestination(
                //   icon: Icon(Icons.miscellaneous_services),
                //   label: Text("Service"),
                // ),
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
                            DataColumn(label: Text(" Delete")),
                            DataColumn(label: Text(" Edit")),
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
                                  handleDelete(user['user_id']);
                                },
                                child: const Icon(
                                  IconData(0xe1b9, fontFamily: 'MaterialIcons'),
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                              DataCell(TextButton(
                                onPressed: () {
                                  ccname.text = user['user_name'];
                                  ccgmail.text = user['craftmen_gmail'];
                                  ccphone.text = user['craftmen_phone'];
                                  ccgender.text = user['gender'];
                                  cccity.text = user['craftmen_city'];
                                  ccpass.text = user['password'];
                                  cccpass.text = user['cpassword'];
                                  ccost.text = user['price'];
                                  cem.text = user['emergency'];
                                  _cdateTimeController.text =
                                      user['working_day'];
                                  //  selectedJob!.jobName = user['job'];
                                  // selectedJob?.jobId = user['jop_id'];
                                  // selectedJob?.jobName = user['job'];
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            actions: [
                                              const Row(
                                                children: [
                                                  Text(
                                                    "Edit Craftmen",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      fontSize: 22,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 20,
                                                // height: 20,
                                              ),
                                              TextFormField(
                                                controller: ccname,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Username",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ccgmail,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Gmail",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ccphone,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Phone Number",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ccgender,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Gender",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: ccpass,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Password",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: cccpass,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Conform Password",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: cccity,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "City",
                                                ),
                                              ),
                                              DropdownButtonFormField<Job>(
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Which field',
                                                    labelStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 76, 155, 207),
                                                    ),
                                                  ),
                                                  value: selectedJob,
                                                  onChanged: (Job? newValue) {
                                                    setState(() {
                                                      selectedJob = newValue!;
                                                    });
                                                  },
                                                  items: jobs.map<
                                                      DropdownMenuItem<
                                                          Job>>((Job job) {
                                                    return DropdownMenuItem<
                                                        Job>(
                                                      value: job,
                                                      child: Text(job.jobName),
                                                    );
                                                  }).toList()),
                                              TextFormField(
                                                controller: ccost,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Cost per hour",
                                                ),
                                              ),
                                              TextFormField(
                                                controller: cem,
                                                decoration:
                                                    const InputDecoration(
                                                  focusColor: Color.fromARGB(
                                                      255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText:
                                                      "Can work in Emergency (Y or N)",
                                                ),
                                              ),
                                              TextFormField(
                                                controller:
                                                    _cdateTimeController,
                                                decoration: InputDecoration(
                                                  suffixIcon: GestureDetector(
                                                    onTap: () {
                                                      _showDateTimeRangePicker(
                                                          context);
                                                    },
                                                    child: const Icon(
                                                        Icons.calendar_today),
                                                  ),
                                                  focusColor:
                                                      const Color.fromARGB(
                                                          255, 241, 241, 241),
                                                  hoverColor: Colors.black,
                                                  hintText: "Working hours",
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
                                                    handleEdit(user);
                                                    fetchData();
                                                    ccname.clear();
                                                    ccgmail.clear();
                                                    ccpass.clear();
                                                    cccpass.clear();
                                                    ccphone.clear();
                                                    cccity.clear();
                                                    ccgender.clear();
                                                    cem.clear();
                                                    _cdateTimeController
                                                        .clear();
                                                    ccost.clear();
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
          cname.clear();
          cgmail.clear();
          pass.clear();
          cpass.clear();
          cphone.clear();
          ccity.clear();
          cgender.clear();
          em.clear();
          _dateTimeController.clear();
          cost.clear();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    actions: [
                      Row(
                        children: [
                          Title(
                              color: Colors.black,
                              child: const Text("Add Craftmen",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 22))),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                        // height: 20,
                      ),
                      TextFormField(
                        controller: cname,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Username",
                        ),
                      ),
                      TextFormField(
                        controller: cgmail,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Gmail",
                        ),
                      ),
                      TextFormField(
                        controller: cphone,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Phone Number",
                        ),
                      ),
                      TextFormField(
                        controller: cgender,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Gender",
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
                          hintText: "Conform Password",
                        ),
                      ),
                      TextFormField(
                        controller: ccity,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "City",
                        ),
                      ),
                      DropdownButtonFormField<Job>(
                          decoration: const InputDecoration(
                            labelText: 'Which field',
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 76, 155, 207),
                            ),
                          ),
                          value: selectedJob,
                          onChanged: (Job? newValue) {
                            setState(() {
                              selectedJob = newValue!;
                            });
                          },
                          items: jobs.map<DropdownMenuItem<Job>>((Job job) {
                            return DropdownMenuItem<Job>(
                              value: job,
                              child: Text(job.jobName),
                            );
                          }).toList()),
                      TextFormField(
                        controller: cost,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Cost per hour",
                        ),
                      ),
                      TextFormField(
                        controller: em,
                        decoration: const InputDecoration(
                          focusColor: Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Can work in Emergency (Y or N)",
                        ),
                      ),
                      TextFormField(
                        controller: _cdateTimeController,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              _showDateTimeRangePicker(context);
                            },
                            child: const Icon(Icons.calendar_today),
                          ),
                          focusColor: const Color.fromARGB(255, 241, 241, 241),
                          hoverColor: Colors.black,
                          hintText: "Working hours",
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
                            addcraftmen();
                            fetchData();
                            cname.clear();
                            cgmail.clear();
                            pass.clear();
                            cpass.clear();
                            cphone.clear();
                            ccity.clear();
                            cgender.clear();
                            em.clear();
                            _dateTimeController.clear();
                            cost.clear();
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
