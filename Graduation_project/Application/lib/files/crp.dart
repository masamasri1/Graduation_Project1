import 'package:flutter/material.dart';
import 'package:graduation_project/files/profilecraft.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/link.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/files/crafts.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class editProfilePage extends StatefulWidget {
  // final String craftsmanName;
  // editProfilePage({required this.craftsmanName});
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<editProfilePage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController emergencyController = TextEditingController();
  TextEditingController workingDayController = TextEditingController();

  Future<void> handleEdit() async {
    final response = await http.post(
      Uri.parse(applink.c),
      body: {
        'user_name': userNameController.text,
        'craftmen_gmail': gmailController.text,
        'craftmen_phone': phoneNumberController.text,
        'password': passwordController.text,
        'cpassword': confirmPasswordController.text,
        'craftmen_city': cityController.text,
        'price': priceController.text,
        'emergency': emergencyController.text,
        'working_day': time.text,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CraftsmenProfilePage(
                    craftsmanName: userNameController.text,
                  )));
    } else {
      print("HTTP Error: ${response.statusCode}");
      Fluttertoast.showToast(msg: "Failed to update profile");
    }
  }

  // _showDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Select Date Range'),
  //         content: ElevatedButton(
  //           onPressed: () => ShowDatePicker(context),
  //           child: Text("Pick Date Range"),
  //         ),
  //         actions: <Widget>[
  //           ElevatedButton(
  //             child: Text('Close'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // ShowDatePicker(BuildContext context) async {
  //   List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
  //     context: context,
  //     startInitialDate: DateTime.now(),
  //     startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
  //     startLastDate: DateTime.now().add(
  //       const Duration(days: 3652),
  //     ),
  //     endInitialDate: DateTime.now(),
  //     endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
  //     endLastDate: DateTime.now().add(
  //       const Duration(days: 3652),
  //     ),
  //     is24HourMode: false,
  //     isShowSeconds: false,
  //     minutesInterval: 1,
  //     secondsInterval: 1,
  //     borderRadius: const BorderRadius.all(Radius.circular(16)),
  //     constraints: const BoxConstraints(
  //       maxWidth: 350,
  //       maxHeight: 650,
  //     ),
  //     transitionBuilder: (context, anim1, anim2, child) {
  //       return FadeTransition(
  //         opacity: anim1.drive(
  //           Tween(
  //             begin: 0,
  //             end: 1,
  //           ),
  //         ),
  //         child: child,
  //       );
  //     },
  //     transitionDuration: const Duration(milliseconds: 200),
  //     barrierDismissible: true,
  //     selectableDayPredicate: (dateTime) {
  //       // Disable 25th Feb 2023
  //       if (dateTime == DateTime(2023, 2, 25)) {
  //         return false;
  //       } else {
  //         return true;
  //       }
  //     },
  //   );
  //   if (dateTimeList != null && dateTimeList.length == 2) {
  //     setState(() {
  //       workingDayController.text =
  //           "from: ${dateTimeList[0]}, to: ${dateTimeList[1]}";
  //     });
  //   }
  // }
  TextEditingController time = TextEditingController();
  _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Date Range'),
          content: ElevatedButton(
            onPressed: () => showTimePickerDialog(context),
            child: Text("Pick Date Range"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showTimePickerDialog(BuildContext context) async {
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: startTime,
      );

      if (endTime != null) {
        setState(() {
          time.text = "from: $startTime, to: $endTime";
        });
      }
    }
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 70, 200, 236),
            Color.fromARGB(255, 76, 155, 207),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        onChanged: (value) {},
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildRoundedTextField(
                  controller: userNameController,
                  labelText: 'User Name',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: gmailController,
                  labelText: 'Email',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: phoneNumberController,
                  labelText: 'Phone Number',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: passwordController,
                  labelText: 'Password',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: cityController,
                  labelText: 'City',
                ),
                // SizedBox(height: 25),
                // _buildRoundedTextField(
                //   controller: jobController,
                //   labelText: 'Job',
                // ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: priceController,
                  labelText: 'Price',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: emergencyController,
                  labelText: 'Emergency',
                ),
                SizedBox(height: 25),
                _buildRoundedTextField(
                  controller: workingDayController,
                  labelText: 'Working Day',
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      //  DateRangePickerDemo();
                      //date();
                      _showDialog(context);
                    },
                    child: Text('pick your working days/hours')),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    handleEdit();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
