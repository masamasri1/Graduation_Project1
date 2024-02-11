import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/data/datasours/remote/testdata.dart';
import 'package:graduation_project/files/cleaningpage.dart';
import 'package:graduation_project/files/crafts.dart';
import 'package:graduation_project/files/login.dart';
import 'package:graduation_project/files/menu.dart';
import 'package:graduation_project/files/welcome.dart';
//import 'package:graduation_project/signupascraft2.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
//import 'package:graduation_project/files/crafts.dart';
import 'package:graduation_project/link.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class signupascraft extends StatefulWidget {
  const signupascraft({Key? key}) : super(key: key);
  @override
  State<signupascraft> createState() => signupascraftstate();
}

class signupascraftstate extends State<signupascraft> {
  // final fullNameController = TextEditingController();
  // final gmailController = TextEditingController();
  // final phoneNumberController = TextEditingController();
  // final passwordController = TextEditingController();
  // final confirmPasswordController = TextEditingController();
  // final cityController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController cpassword = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController job = TextEditingController();
  TextEditingController em = TextEditingController();
  TextEditingController time = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController id = TextEditingController();

  List<Job> jobs = [
    Job(jobId: 1, jobName: 'Carpenter'),
    Job(jobId: 2, jobName: 'Cleaning'),
    Job(jobId: 3, jobName: 'Driver'),
    Job(jobId: 4, jobName: 'Electrician'),
    Job(jobId: 5, jobName: 'Gardener'),
    Job(jobId: 6, jobName: 'Painter'),
    Job(jobId: 7, jobName: 'Tailor'),
    Job(jobId: 8, jobName: 'Plumber'),
    Job(jobId: 9, jobName: 'Smith'),
    Job(jobId: 10, jobName: 'Tiler'),
  ];

  Job? selectedJob;
  validatee() async {
    try {
      var ress = await http.post(Uri.parse(applink.valsi), body: {
        'craftmen_gmail': gmail.text.trim(),
      });
      if (ress.statusCode == 200) {
        var m = jsonDecode(ress.body);
        if (m['emailfound'] == true) {
          Fluttertoast.showToast(msg: "already exist");
        } else {
          registerUser();
        }
      }
    } catch (e) {}
  }

  registerUser() async {
    craft us = craft(
        username.text.trim(),
        gmail.text.trim(),
        phonenumber.text.trim(),
        password.text.trim(),
        cpassword.text.trim(),
        city.text.trim(),
        //job.text.trim(),
        selectedJob!.jobName,
        price.text.trim(),
        em.text.trim(),
        time.text.trim(),
        selectedJob!.jobId);
    print(us);
    // Validate the user input here if necessary,
    // e.g. check if passwords match, if email is valid, etc.

    try {
      var res = await http.post(
        Uri.parse(applink.scraft),
        body: us.toJson(),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );
      print("Server Response: ${res.body}");

      // Check for unexpected server responses:
      if (res.statusCode == 200) {
        var en = jsonDecode(res.body);
        if (en['success'] == true) {
          Fluttertoast.showToast(msg: "Success");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Welcome()));
        } else {
          Fluttertoast.showToast(
              msg: "try again"); // Display specific error if provided
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

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
  //       time.text = "from: ${dateTimeList[0]}, to: ${dateTimeList[1]}";
  //     });
  //   }
  // }

  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    String passwordText =
        isPasswordVisible ? password.text : '•' * password.text.length;
    String passwordText2 =
        isPasswordVisible ? cpassword.text : '•' * cpassword.text.length;
    return Scaffold(
        body: Stack(
      //thanks for watching
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 70, 200, 236),
              Color.fromARGB(255, 76, 155, 207),
            ]),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              'Create Your\nAccount',
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 250, 250, 250),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 130.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: username,
                        decoration: InputDecoration(
                            label: Text(
                          'Full Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: gmail,
                        decoration: InputDecoration(
                            label: Text(
                          ' Gmail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: phonenumber,
                        decoration: InputDecoration(
                            label: Text(
                          ' phone number ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: password,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            label: Text(
                              'Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 76, 155, 207),
                              ),
                            )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextField(
                        controller: cpassword,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                            label: Text(
                              'Conform Password',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 76, 155, 207),
                              ),
                            )),
                      ),
                      TextField(
                        controller: city,
                        decoration: InputDecoration(
                            label: Text(
                          ' City ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      // const SizedBox(
                      //   height: 70,
                      // ),
                      // GestureDetector(
                      // onTap: () {
                      // Navigator.push(context,
                      //MaterialPageRoute(builder: (context) => crafts()));
                      // },
                      // child: Container(
                      //  height: 55,
                      // width: 300,
                      // decoration: BoxDecoration(
                      // borderRadius: BorderRadius.circular(30),
                      // gradient: const LinearGradient(colors: [
                      // Color.fromARGB(255, 211, 236, 70),
                      // Color.fromARGB(255, 76, 155, 207),
                      //]),
                      //  ),
                      // child: const Center(
                      // child: Text(
                      // 'Next',
                      //style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      // fontSize: 20,
                      // color: Colors.white),
                      //  ),
                      // ),
                      //),
                      //),

                      DropdownButtonFormField<Job>(
                        decoration: InputDecoration(
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
                        }).toList(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: price,
                        decoration: InputDecoration(
                            label: Text(
                          'How much do you get paid per Day?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      TextField(
                        controller: em,
                        decoration: InputDecoration(
                            label: Text(
                          'Can you work in emergency situations(Y or N)?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        controller: time,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Selected Date Range",
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        ),
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
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 55,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 70, 200, 236),
                            Color.fromARGB(255, 76, 155, 207),
                          ]),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            //registerUser();
                            if (formkey.currentState!.validate()) {
                              validatee();
                            }

                            // registerUser();
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => menu()));
                          },
                          child: const Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.bottomRight,
                      //   child: Column(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       Padding(
                      //         padding:
                      //             const EdgeInsets.symmetric(horizontal: 25.0),
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.end,
                      //           children: [
                      //             GestureDetector(
                      //               onTap: () {
                      //                 Navigator.push(
                      //                     context,
                      //                     MaterialPageRoute(
                      //                         builder: (context) =>
                      //                             signupascraft2(
                      //                               username:
                      //                                   fullNameController.text,
                      //                               gmail: gmailController.text,
                      //                               phoneNumber:
                      //                                   phoneNumberController
                      //                                       .text,
                      //                               password:
                      //                                   passwordController.text,
                      //                               cpassword:
                      //                                   confirmPasswordController
                      //                                       .text,
                      //                               city: cityController.text,
                      //                             )));
                      //               },
                      //               child: Text(
                      //                 "Next",
                      //                 style: TextStyle(
                      //                   fontSize: 20,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Color.fromARGB(255, 76, 155, 207),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }

  // @override
  // void dispose() {
  //   fullNameController.dispose();
  //   gmailController.dispose();
  //   phoneNumberController.dispose();
  //   passwordController.dispose();
  //   confirmPasswordController.dispose();
  //   cityController.dispose();
  //   super.dispose();
  // }
}
