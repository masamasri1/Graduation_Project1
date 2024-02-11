import 'package:email_auth/email_auth.dart';
import 'dart:convert';

import 'package:email_auth/email_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/class/curd.dart';
import 'package:graduation_project/files/resetpass.dart';
import 'package:graduation_project/files/theme_helper.dart';
//import 'package:flutter_login_ui/common/theme_helper.dart';
//import 'package:flutter_login_ui/constant/link.dart';
//import 'package:flutter_login_ui/pages/Resetpassword.dart';
//import 'package:flutter_login_ui/pages/component/crud.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
//mport 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/link.dart';

//import 'widgets/header_widget.dart';

class ForgotPasswordVerificationPage extends StatefulWidget {
  const ForgotPasswordVerificationPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordVerificationPageState createState() =>
      _ForgotPasswordVerificationPageState();
}

class _ForgotPasswordVerificationPageState
    extends State<ForgotPasswordVerificationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _pinSuccess = false;
  Crud _crud = Crud();
  String? otpValue;
  // OtpFieldControllerExtended verfiycode = OtpFieldControllerExtended();
  // OtpFieldControllerExtended verfiycodee = OtpFieldControllerExtended();
  TextEditingController email = new TextEditingController();
  //TextEditingController verfiycode = new TextEditingController();
  OtpFieldController verfiycode = OtpFieldController();
  //OtpFieldController verfiycode = OtpFieldController();
  forgot_password_verification() async {
    // var response = await _crud.postRequest(linkveryfiecode, {

    //             "email" :email.text,
    //            "verfiycode":verfiycode.text,

    // });
    // var response = await http.post(
    //   Uri.parse(applink.send),
    //   body: {
    //     'gmail': email.text,
    //     'varify': otpValue,
    //   },
    // );
    //  if (response['status'] == "success") {
    //   // ignore: use_build_context_synchronously
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ResetPasswordPage()));
    // } else {
    //   print(" Fail");
    // }
    //print(otpValue);

    //   if (response['status'] == "success") {
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => ResetPasswordPage()));
    //   } else {
    //     print("resend");

    // }

    var response = await _crud.postRequest(applink.send, {
      'gmail': email.text,
      'varify': otpValue,
    });
    if (response['status'] == "success") {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ResetPasswordPage()));
    } else {
      print(" Fail");
    }

    // if (response['status'] == "success") {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => ResetPasswordPage()));
    // } else {
    //   print("forgot_password_verification Fail");
    // }
  }

  String? s;
  String? m;
  @override
  Widget build(BuildContext context) {
    double _headerHeight = 300;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(
                    _headerHeight, true, Icons.privacy_tip_outlined),
              ),
              SafeArea(
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Verification',
                              style: TextStyle(
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(173, 45, 183, 236),
                              ),
                              // textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Enter the verification code we just sent you on your email address.',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(173, 99, 183, 236)),
                              // textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: OTPTextField(
                                //controller: verfiycodee,
                                length: 4,
                                width: 300,
                                fieldWidth: 50,
                                style: TextStyle(fontSize: 30),
                                textFieldAlignment:
                                    MainAxisAlignment.spaceAround,
                                fieldStyle: FieldStyle.underline,
                                onChanged: (value) {},
                                onCompleted: (pin) {
                                  setState(() {
                                    _pinSuccess = true;
                                    otpValue = pin;
                                  });
                                },
                                //controller: verfiycode;
                              ),
                            ),
                            SizedBox(height: 50.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "If you didn't receive a code ! ",
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(173, 99, 183, 236),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  TextSpan(
                                    text: 'Resend',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Successful",
                                                "Verification code resend successful.",
                                                context);
                                          },
                                        );
                                      },
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(173, 99, 183, 236)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 40.0),
                            Container(
                              decoration: _pinSuccess
                                  ? ThemeHelper().buttonBoxDecoration(context)
                                  : ThemeHelper()
                                      .buttonBoxDecoration(context, "#440065"),
                              // decoration: _pinSuccess ? ThemeHelper().buttonBoxDecoration(context):ThemeHelper().buttonBoxDecoration(context,"#7b1fa2"),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(70, 10, 70, 10),
                                  child: Text(
                                    "Verify".toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  // var ss=0;
                                  // if (verification.verify(ss!, s!))
                                  await forgot_password_verification();
                                  //                               if (verification.verify(email.text, verfiycode.textValue))  // Again, assuming textValue gives the OTP
                                  // await forgot_password_verification();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class verification {
  static EmailAuth emailAuth = new EmailAuth(
    sessionName: 'ONDUTY',
  );
  static late bool result;
  static void sendOtp(String s) async {
    result = await emailAuth.sendOtp(recipientMail: s, otpLength: 6);
  }

  static bool verify(String s1, String s2) {
    bool res = (emailAuth.validateOtp(recipientMail: s1, userOtp: s2));
    if (res) {
      return true;
    } else
      return false;
  }
}

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

    //var accentColor;
    return Container(
      child: Stack(
        children: [
          ClipPath(
            child: Container(
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      Theme.of(context).primaryColor.withOpacity(0.4),
                      // Color.fromARGB(255, 76, 155, 207),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
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
                      Theme.of(context).primaryColor.withOpacity(0.4),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
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
                      Theme.of(context).primaryColor,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
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

// class OtpFieldControllerExtended extends OtpFieldController {
//   String get currentValue {
//     // Assuming your OtpFieldController has a way to access the current value
//     // Replace with the appropriate method/property
//     return currentValue;
//   }
// }

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
