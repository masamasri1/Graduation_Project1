import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/data/datasours/remote/testdata.dart';
import 'package:graduation_project/files/crafts.dart';
import 'package:graduation_project/files/signupascraft.dart';
import 'package:graduation_project/files/welcome.dart';
import 'package:graduation_project/link.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);
  @override
  State<signup> createState() => signupstate();
}

class signupstate extends State<signup> {
  var formkey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController gmail1 = TextEditingController();
  TextEditingController cpassword1 = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController city1 = TextEditingController();
  // TextEditingController user_id = TextEditingController();
  //var formkey = GlobalKey <FormState> ();

  validatee() async {
    try {
      var ress = await http.post(Uri.parse(applink.validate), body: {
        'gmail': gmail1.text.trim(),
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
    users us = users(
        username.text.trim(),
        gmail1.text.trim(),
        phonenumber.text.trim(),
        password1.text.trim(),
        cpassword1.text.trim(),
        city1.text.trim());

    // Validate the user input here if necessary,
    // e.g. check if passwords match, if email is valid, etc.

    try {
      var res = await http.post(
        Uri.parse(applink.sign),
        body: us.toJson(),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
      );

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

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    String passwordText =
        isPasswordVisible ? password1.text : '•' * password1.text.length;
    String password1Text =
        isPasswordVisible ? cpassword1.text : '•' * cpassword1.text.length;
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
              'Create Your Account',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.only(top: 120.0),
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
                      TextFormField(
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
                      TextFormField(
                        controller: gmail1,
                        decoration: InputDecoration(
                            label: Text(
                          ' Gmail',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      TextFormField(
                        controller: phonenumber,
                        decoration: InputDecoration(
                            label: Text(
                          ' Phone number ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 76, 155, 207),
                          ),
                        )),
                      ),
                      TextField(
                        controller: password1,
                        onChanged: (value) {},
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
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
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: cpassword1,
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
                      TextFormField(
                        controller: city1,
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
                      const SizedBox(
                        height: 70,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            validatee();
                          }

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => crafts()));
                        },
                        child: Container(
                          height: 55,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 70, 200, 236),
                              Color.fromARGB(255, 76, 155, 207),
                            ]),
                          ),
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
                      SizedBox(
                        height: 45,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "sign up as a craftsmen?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 76, 155, 207),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  signupascraft()));
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        ///done login page
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color:
                                            Color.fromARGB(255, 76, 155, 207),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
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
}
