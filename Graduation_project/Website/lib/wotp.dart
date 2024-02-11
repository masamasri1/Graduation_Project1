import 'package:flutter/material.dart';
import 'package:flutter_responsive/class/Crud.dart';
import 'package:flutter_responsive/resetpass.dart';
import 'package:flutter_responsive/wresetpass.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'connection/connect.dart';

class workerotp extends StatefulWidget {
  final String email;
  const workerotp({Key? key, required this.email}) : super(key: key);

  @override
  State<workerotp> createState() => _workerotpState();
}

class _workerotpState extends State<workerotp> {
  bool _pinSuccess = false;
  Crud _crud = Crud();
  String? otpValue;
  // TextEditingController email = new TextEditingController();
  OtpFieldController verfiycode = OtpFieldController();
  forgot_password_verification() async {
    var response = await _crud.postRequest(applink.wsend, {
      'craftmen_gmail': widget.email,
      'varify': otpValue,
    });
    if (response['status'] == "success") {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => wresetpass(email: widget.email)));
    } else {
      print(" Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    // String otp = (one.text) + (two.text) + (three.text) + (four.text);

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
        height: 400,
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
                height: 100,
                width: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                ".OTP Code",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 40,
                style: TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.underline,
                onChanged: (value) {},
                onCompleted: (pin) {
                  setState(() {
                    _pinSuccess = true;
                    otpValue = pin;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    minimumSize: const Size(240, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7))),
                onPressed: () {
                  forgot_password_verification();
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
