import 'package:flutter/material.dart';
import 'package:flutter_responsive/adminlogin.dart';
import 'package:flutter_responsive/class/Crud.dart';
import 'connection/connect.dart';

class resetpass extends StatefulWidget {
  final String email;
  const resetpass({Key? key, required this.email}) : super(key: key);

  @override
  State<resetpass> createState() => _resetpassState();
}

class _resetpassState extends State<resetpass> {
  Crud _crud = Crud();
  bool h = true;
  bool h1 = true;

  //TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController confirm_password = new TextEditingController();
  RessetPassword() async {
    var response = await _crud.postRequest(applink.reset, {
      'admin_gmail': widget.email,
      'admin_pass': password.text,
      'admin_cpass': confirm_password.text,
    });
    // print(widget.email);

    if (response['status'] == "success") {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminLogin()));
    } else {
      print(widget.email);
      print("RessetpasswordFail");
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

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
                height: 50,
                width: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Reset Password",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              // TextFormField(
              //   //  controller: email,
              //   decoration: InputDecoration(
              //     focusColor: const Color.fromARGB(255, 241, 241, 241),
              //     hoverColor: Colors.black,
              //     hintText: "Enter Email",
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),

              TextFormField(
                obscureText: h,
                controller: password,
                decoration: InputDecoration(
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
                  hintText: "Enter New Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: h,
                controller: confirm_password,
                decoration: InputDecoration(
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
                  hintText: "Conform New Password",
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
                  RessetPassword();
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
