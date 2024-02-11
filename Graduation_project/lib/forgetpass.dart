import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/class/Crud.dart';
import 'package:flutter_responsive/otp.dart';
import 'connection/connect.dart';
import 'package:flutter_responsive/adminlogin.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AdminForgetpass extends StatefulWidget {
  const AdminForgetpass({super.key});

  @override
  State<AdminForgetpass> createState() => _AdminForgetpass();
}

class _AdminForgetpass extends State<AdminForgetpass> {
  TextEditingController fpass = TextEditingController();
  Crud _crud = Crud();
  Future _resetPassword() async {
    var response = await _crud.postRequest(applink.adminforgetpass, {
      'admin_gmail': fpass.text,
    });
    if (response['status'] == "success") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => adminotp(email: fpass.text)));
    } else {
      print("forgot_password_verification Fail");
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
          //     child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < 893) {
              return Column(
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  responsiveCard(),
                ],
              );
            } else {
              return Row(
                //  mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: w / 3.5,
                  ),
                  SizedBox(
                    width: w / 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: responsiveCard(),
                  ),
                ],
              );
            }
          }),
        ),
        //  ),
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
              const Image(
                image: AssetImage("img/ll.png"),
                height: 130,
                width: 130,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Forget Your Password",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: fpass,
                decoration: InputDecoration(
                  focusColor: const Color.fromARGB(255, 241, 241, 241),
                  hoverColor: Colors.black,
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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
                  _resetPassword();
                },
                child: const Text(
                  "Send New Password",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const AdminLogin(),
                    ),
                  );
                },
                child: const Text(
                  " Back to LogIn page.",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
