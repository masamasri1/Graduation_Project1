import 'dart:typed_data';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/ChatScreen.dart';
import 'package:flutter_responsive/main.dart';
import 'package:flutter_responsive/workercraftmen.dart';
import 'package:flutter_responsive/workerrequest.dart';
import 'package:flutter_responsive/workerstatic.dart';
import 'package:flutter_responsive/workeruser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'connection/connect.dart';

// ignore: camel_case_types02
class profile extends StatefulWidget {
  final String email;
  const profile({Key? key, required this.email}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

// ignore: camel_case_types
class _profileState extends State<profile> {
  TextEditingController _cdateTimeController = TextEditingController();
  TextEditingController ccname = TextEditingController();
  TextEditingController ccgmail = TextEditingController();
  TextEditingController ccpass = TextEditingController();
  TextEditingController cccpass = TextEditingController();
  TextEditingController ccphone = TextEditingController();
  TextEditingController cccity = TextEditingController();
  TextEditingController cem = TextEditingController();
  TextEditingController ccgender = TextEditingController();
  TextEditingController ccost = TextEditingController();
  // DateTime? _selectedStartDateTime;
  // DateTime? _selectedEndDateTime;
  TimeOfDay? _selectedStartTime;
  TimeOfDay? _selectedEndTime;
  bool showInfoBox = false;
  String? selectedUserId;
  String avatarPhoto = "";

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

  bool isExpanded = false;
  int _selecteIndex = 0;
  List<Map<String, dynamic>> _userData = [];
  List<Map<String, dynamic>> _craftmenData = [];
  List<Map<String, dynamic>> _resData = [];
  List<Map<String, dynamic>> _rateData = [];
  List<Map<String, dynamic>> _adminData = [];
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      profile(email: widget.email),
      workeruser(email: widget.email),
      workercraftmen(email: widget.email),
      WorkerRequest(email: widget.email),
      Workerstatic(email: widget.email),
    ];
    RatingData();
    userData();
    craftmenData();
    ReservationData();
    adminData();
  }

  Widget generateStarRating(String ratingString) {
    double rating = double.parse(ratingString);
    return Row(
      children: List.generate(5, (index) {
        double starValue = index + 1.0;
        return Icon(
          starValue <= rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        );
      }),
    );
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
    try {
      var response = await http.post(Uri.parse(applink.showrate));
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        print('Response Data: $responseData');

        if (responseData['status'] == 'success') {
          setState(() {
            _rateData = List<Map<String, dynamic>>.from(responseData['data']);
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
      'craftmen_gmail': widget.email,
      'aphoto': base64Photo,
    };

    try {
      var response = await http.post(
        Uri.parse(applink.cphoto),
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
        // fetchData();
        craftmenData();
      } else {
        // Handle error
        print("Failed to update craftmen: ${response.reasonPhrase}");
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    String email = widget.email;
    List uname = _userData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['users_user_name'])
        .toList();
    List pname = _craftmenData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    List rname = _resData
        .where((map) => map['craftmen_gmail'] == email)
        .map((map) => map['user_name'])
        .toList();
    //List admin = _adminData.map((map) => map['admin_gmail']).toList();

    int u = uname.length;
    int r = rname.length;
    int p = pname.length;

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
                            _craftmenData
                                .where((map) => map['craftmen_gmail'] == email)
                                .map((user) {
                              ccname.text = user['user_name'];
                              ccgmail.text = user['craftmen_gmail'];
                              ccphone.text = user['craftmen_phone'];
                              ccgender.text = user['gender'];
                              cccity.text = user['craftmen_city'];
                              ccpass.text = user['password'];
                              cccpass.text = user['cpassword'];
                              ccost.text = user['price'];
                              cem.text = user['emergency'];
                              _cdateTimeController.text = user['working_day'];
                            }).toList();
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
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Username",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: ccgmail,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Gmail",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: ccphone,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Phone Number",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: ccgender,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Gender",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: ccpass,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Password",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: cccpass,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Conform Password",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: cccity,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "City",
                                          ),
                                        ),
                                        DropdownButtonFormField<Job>(
                                            decoration: const InputDecoration(
                                              labelText: 'Which field',
                                              labelStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
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
                                            items: jobs
                                                .map<DropdownMenuItem<Job>>(
                                                    (Job job) {
                                              return DropdownMenuItem<Job>(
                                                value: job,
                                                child: Text(job.jobName),
                                              );
                                            }).toList()),
                                        TextFormField(
                                          controller: ccost,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText: "Cost per hour",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: cem,
                                          decoration: const InputDecoration(
                                            focusColor: Color.fromARGB(
                                                255, 241, 241, 241),
                                            hoverColor: Colors.black,
                                            hintText:
                                                "Can work in Emergency (Y or N)",
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _cdateTimeController,
                                          decoration: InputDecoration(
                                            suffixIcon: GestureDetector(
                                              onTap: () {
                                                _showDateTimeRangePicker(
                                                    context);
                                              },
                                              child: const Icon(
                                                  Icons.calendar_today),
                                            ),
                                            focusColor: const Color.fromARGB(
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
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7))),
                                            onPressed: () {
                                              _craftmenData
                                                  .where((map) =>
                                                      map['craftmen_gmail'] ==
                                                      email)
                                                  .map((user) {
                                                handleEdit(user);
                                                craftmenData();
                                                Navigator.of(context).pop();
                                              }).toList();
                                            },
                                            child: const Text("Submit"))
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
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => chatpage(
                                          email: email,
                                          reseve: 'mosamis.2000@gmail.com',
                                        )));
                            setState(() {});
                          },
                          child: const Icon(
                            IconData(0xe3e0, fontFamily: 'MaterialIcons'),
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        )
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
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: _craftmenData
                                      .where((map) =>
                                          map['craftmen_gmail'] == email)
                                      .map((user) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Name: ${user['user_name']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Gmail: ${user['craftmen_gmail']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Job: ${user['job']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Price: ${user['price']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Emergency: ${user['emergency']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Work_day: ${user['working_day']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Phone Number: ${user['craftmen_phone']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "City: ${user['craftmen_city']}",
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                          Text(
                                            "Password: ${user['password']}",
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
                            width: 20,
                            height: 20,
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
                                              "Number of Reservation:$r",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                          const Flexible(
                              child: SizedBox(
                            width: 20,
                            height: 20,
                          )),
                          Flexible(
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: _rateData
                                        .where((map) =>
                                            map['craftmen_gmail'] == email)
                                        .isEmpty
                                    ? Column(
                                        children: [
                                          const Text(
                                              "No Comment OR Rating Until Now",
                                              style: TextStyle(fontSize: 15)),
                                          generateStarRating("0")
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: _rateData
                                            .where((map) =>
                                                map['craftmen_gmail'] == email)
                                            .map((user) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "User_Name: ${user['users_user_name']}",
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  "Comment: ${user['comment']}",
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                                Center(
                                                  child: generateStarRating(
                                                      user['rating']),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
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
