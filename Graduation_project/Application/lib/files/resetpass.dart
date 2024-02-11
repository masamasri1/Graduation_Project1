import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/core/class/curd.dart';
import 'package:graduation_project/files/login.dart';
import 'package:graduation_project/files/theme_helper.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/link.dart';

//import 'widgets/header_widget.dart';
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  double _headerHeight = 250;
  // GlobalKey<FormState> formstate = GlobalKey();
  //GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  //Key _formKey = GlobalKey<FormState>();
  Crud _crud = Crud();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirm_password = new TextEditingController();
  RessetPassword() async {
    var response = await _crud.postRequest(applink.reset, {
      'gmail': email.text,
      'password': password.text,
      'cpassword': password.text,
    });
    if (response['status'] == "success") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => login()));
    } else {
      print("RessetpasswordFail");
    }
    //   // final response = await http.post(Uri.parse(applink.reset), body: {
    //   //   "gmail": email.text,
    //   //   "password": password.text,
    //   //   "cpassword": confirm_password.text,
    //   // });
    //   // if (response.statusCode == 200) {
    //   //   var en = jsonDecode(response.body);
    //   //   if (en['success'] == true) {
    //   //     Navigator.push(
    //   //         context, MaterialPageRoute(builder: (context) => login()));
    //   //   } else {
    //   //     print("wrong");
    //   //   }
    //   // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 125, 217, 240),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(
                  _headerHeight,
                  true,
                  Icons
                      .password_outlined), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      /* Text(
                      'FIT GYM',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),*/
                      // SizedBox(height: 15,),
                      Text(
                        'New Password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                            color: Color.fromARGB(220, 97, 168, 235)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Please Enter New Password',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(173, 99, 183, 236)),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                width: 1000,
                                child: TextFormField(
                                  //controller: email,
                                  controller: email,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "E-mail address", "Enter your email"),

                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (!(val!.isEmpty) &&
                                        !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                            .hasMatch(val)) {
                                      return "Enter a valid email address";
                                    }
                                    return null;
                                  },
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextField(
                                  controller: password,
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'confirmation_Password',
                                      'Enter your confirmation_password'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 25.0),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  onPressed: () async {
                                    await RessetPassword();
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(70, 10, 70, 10),
                                    child: Text(
                                      'Save'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

//import 'package:flutter/material.dart';

class HeaderWidget extends StatefulWidget {
  final double _height;
  final bool _showIcon;
  final IconData _icon;

  const HeaderWidget(
    this._height,
    this._showIcon,
    this._icon,
  );

  @override
  _HeaderWidgetState createState() =>
      _HeaderWidgetState(_height, _showIcon, _icon);
}

class _HeaderWidgetState extends State<HeaderWidget> {
  double _height;
  bool _showIcon;
  IconData _icon;

  _HeaderWidgetState(this._height, this._showIcon, this._icon);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                      //Theme.of(context).primaryColor.withOpacity(0.4),
                      // Color.fromARGB(255, 76, 155, 207),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: new ShapeClipper([
              Offset(width / 5, _height),
              Offset(width / 10 * 5, _height - 60),
              Offset(width / 5 * 4, _height + 20),
              Offset(width, _height - 18)
            ]),
          ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      //Theme.of(context).accentColor.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondary.withOpacity(0.4)
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: new ShapeClipper([
              Offset(width / 3, _height + 20),
              Offset(width / 10 * 8, _height - 60),
              Offset(width / 5 * 4, _height - 60),
              Offset(width, _height - 20)
            ]),
          ),
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      // Theme.of(context).primaryColor,
                      Theme.of(context).colorScheme.secondary,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
            clipper: new ShapeClipper([
              Offset(width / 5, _height),
              Offset(width / 2, _height - 40),
              Offset(width / 5 * 4, _height - 80),
              Offset(width, _height - 20)
            ]),
          ),
          Visibility(
            visible: _showIcon,
            child: Container(
              height: _height - 40,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.only(
                    left: 5.0,
                    top: 20.0,
                    right: 5.0,
                    bottom: 20.0,
                  ),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(20),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(100),
                      topRight: Radius.circular(100),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    border: Border.all(width: 5, color: Colors.white),
                  ),
                  child: Icon(
                    _icon,
                    color: Colors.white,
                    size: 40.0,
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

class ShapeClipper extends CustomClipper<Path> {
  List<Offset> _offsets = [];
  ShapeClipper(this._offsets);
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height - 20);

    // path.quadraticBezierTo(size.width/5, size.height, size.width/2, size.height-40);
    // path.quadraticBezierTo(size.width/5*4, size.height-80, size.width, size.height-20);

    path.quadraticBezierTo(
        _offsets[0].dx, _offsets[0].dy, _offsets[1].dx, _offsets[1].dy);
    path.quadraticBezierTo(
        _offsets[2].dx, _offsets[2].dy, _offsets[3].dx, _offsets[3].dy);

    // path.lineTo(size.width, size.height-20);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
