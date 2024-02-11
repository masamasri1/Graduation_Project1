import 'dart:convert';
import 'package:flutter_responsive/wforgetpass.dart';
import 'package:flutter_responsive/workerprofile.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'connection/connect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/adminprofile.dart';
import 'forgetpass.dart';
//import 'package:quickalert/quickalert.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _adminloginState();
}

// ignore: camel_case_types
class _adminloginState extends State<AdminLogin> {
  // ignore: non_constant_identifier_names
  TextEditingController user_name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool h = true;
  getadmin() async {
    try {
      var res = await http.post(Uri.parse(applink.adminlogin), body: {
        'admin_gmail': user_name.text.trim(),
        'admin_pass': password.text.trim(),
      });
      if (res.statusCode == 200) {
        var en = jsonDecode(res.body);
        if (en['success'] == true) {
          String email = user_name.text.trim();
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            confirmBtnColor: const Color.fromARGB(255, 54, 244, 73),
            text: "The Password or Email ",
            width: 50,
            customAsset: 'img/succes.gif',
          );
          Fluttertoast.showToast(msg: "Success");
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => admindashhh(email: email)));
        } else {
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: const Color.fromARGB(255, 244, 54, 54),
            text: "The Password or Email ",
            width: 50,
            customAsset: 'img/error.gif',
          );
          Fluttertoast.showToast(
              msg: "try again"); // Display specific error if provided
        }
      }
    } catch (e) {
      print("Error decoding JSON:$e");
    }
  }

  getUser() async {
    try {
      var res = await http.post(Uri.parse(applink.login), body: {
        'craftmen_gmail': user_name.text.trim(),
        'password': password.text.trim(),
      });

      if (res.statusCode == 200) {
        var en = jsonDecode(res.body);
        if (en['success'] == true) {
          String email = user_name.text.trim();
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            confirmBtnColor: const Color.fromARGB(255, 54, 244, 73),
            text: "The Password or Email ",
            width: 50,
            customAsset: 'img/succes.gif',
          );
          Fluttertoast.showToast(msg: "Success");
          // ignore: use_build_context_synchronously
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => profile(email: email)));
        } else {
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            confirmBtnColor: const Color.fromARGB(255, 244, 54, 54),
            text: "The Password or Email ",
            width: 50,
            customAsset: 'img/error.gif',
          );
          Fluttertoast.showToast(
              msg: "try again"); // Display specific error if provided
        }
      }
    } catch (e) {
      print("Error decoding JSON:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    bool h = true;
    return Material(
      //  backgroundColor: const Color.fromARGB(255, 167, 173, 53),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 70, 200, 236),
          Color.fromARGB(255, 76, 155, 207),
        ])),
        child: SingleChildScrollView(
          child: SafeArea(
            child: LayoutBuilder(builder: (context, constraints) {
              if (constraints.maxWidth < 893) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    admin_name(),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: responsiveCard(),
                    ),
                    //    lastPage()
                  ],
                );
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: w / 2.2,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [admin_name()],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w / 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 150),
                      child: Column(
                        children: [
                          responsiveCard(),
                          //  lastPage(),
                        ],
                      ),
                    )
                  ],
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  Card responsiveCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 10,
      shadowColor: Colors.black,
      child: Container(
        height: 370,
        width: 400,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 254, 255, 251),
          Color.fromARGB(255, 93, 213, 250),
        ])),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: user_name,
                decoration: InputDecoration(
                  focusColor: const Color.fromARGB(255, 255, 255, 255),
                  hoverColor: Colors.black,
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              TextFormField(
                controller: password,
                obscureText: h,
                decoration: InputDecoration(
                  //  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        h = !h;
                      });
                    },
                    child: Icon(h ? Icons.visibility : Icons.visibility_off),
                  ),
                  focusColor: const Color.fromARGB(255, 241, 241, 241),
                  hoverColor: Colors.black,
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    //foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7))),
                onPressed: getadmin,
                child: const Text(
                  "Log In as Admin",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    //foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    minimumSize: const Size(double.infinity, 60),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7))),
                onPressed: getUser,
                // QuickAlert.show(
                //   context: context,
                //   type: QuickAlertType.error,
                //   confirmBtnColor: Colors.red,
                //   text: "The Password or Email ",
                //   width: 50,
                //   customAsset: 'img/error.gif',
                // );

                child: const Text(
                  "Log In as Worker",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const AdminForgetpass(),
                        ),
                      );
                    },
                    child: const Text(
                      "Admin",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "OR",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              const WorkerForgetpass(),
                        ),
                      );
                    },
                    child: const Text(
                      "Worker",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 13,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox admin_name() {
    return const SizedBox(
      width: 550,
      child: Column(
        children: [
          Image(
            image: AssetImage("img/ll.png"),
            height: 250,
            width: 250,
          ),
          SizedBox(
            height: 13,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 88),
              child: Text(
                "Welcome to our Website click forget password if you forget yours .",
                style: TextStyle(color: Colors.black, fontSize: 26),
              ),
            ),
          )
        ],
      ),
    );
  }
}
