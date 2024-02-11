//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';
//import 'dart:html';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:graduation_project/core/class/curd.dart';
import 'package:graduation_project/files/cleaningpage.dart';
import 'package:graduation_project/files/pro.dart';
import 'package:graduation_project/files/profilecraft.dart';
import 'package:graduation_project/files/resetpass.dart';
import 'package:graduation_project/files/varifiy.dart';
import 'package:graduation_project/link.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/files/menu.dart';
import 'package:graduation_project/files/crafts.dart';
import 'package:graduation_project/files/pro.dart';
import 'package:graduation_project/files/signup.dart';
import 'package:quickalert/quickalert.dart';
//import 'package:fluttretoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/data/datasours/remote/testdata.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => loginstate();
}

class loginstate extends State<login> {
  void initState() {
    super.initState();
    messaging.getToken().then((token) {
      print(token);
    });
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;

//   messaging.onTokenRefresh.listen((String? token) {
//     print('FCM Token (onTokenRefresh): $token');

//  });

  TextEditingController user_name = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = true;

  TextEditingController gmail = TextEditingController();
  Crud _crud = Crud();

  Future getData() async {
    try {
      var res = await http.post(Uri.parse(applink.login), body: {
        'user_name': user_name.text.trim(),
        'password': password.text.trim(),
      });

      if (res.statusCode == 200) {
        var en = jsonDecode(res.body);
        if (en['success'] == "success1") {
          Fluttertoast.showToast(msg: "Success");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => crafts(userName: user_name.text)));
        } else if (en['success'] == "success2") {
          Fluttertoast.showToast(msg: "Success");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CraftsmenProfilePage(
                        craftsmanName: user_name.text,
                      )));
        } else {
          Fluttertoast.showToast(msg: "Try again");
        }
      }
    } catch (e) {
      print("Error decoding JSON: $e");
    }
  }

  Future _resetPassword() async {
    var response = await _crud.postRequest(applink.forget, {
      'gmail': gmail.text,
    });

    if (response['status'] == "success") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForgotPasswordVerificationPage()));
    } else {
      print("forgot_password_verification Fail");
    }
  }

  void _showForgetPasswordSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      duration: Duration(minutes: 2),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Enter your email address:'),
          TextField(
            controller: gmail,
            decoration: InputDecoration(hintText: 'email@example.com'),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'Reset',
        onPressed: () {
          _resetPassword();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    String passwordText =
        isPasswordVisible ? password.text : '•' * password.text.length;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 70, 200, 236),
                  Color.fromARGB(255, 76, 155, 207),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20.0),
              child: Text(
                'Hello\nSign in!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 170.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20),
                      TextField(
                        controller: user_name,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // Blue
                          ),
                        ),
                      ),
                      TextField(
                        controller: password,
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
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          _showForgetPasswordSnackBar(context);
                        },
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue, // Blue
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      GestureDetector(
                        onTap: () {
                          getData();
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 70, 200, 236),
                                Color.fromARGB(255, 76, 155, 207), // Blue
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 100),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Don't Have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.blue, // Blue
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => signup(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Colors.blue // Blue
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
