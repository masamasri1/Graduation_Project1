// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_login_ui/pages/Support.dart';
// import 'package:flutter_login_ui/pages/card.dart';
// import 'package:flutter_login_ui/pages/chat.dart';
// import 'package:flutter_login_ui/pages/component/crud.dart';
// import 'package:flutter_login_ui/pages/forgot_password_verification_page.dart';
// import 'package:flutter_login_ui/pages/login_page.dart';
// import 'package:flutter_login_ui/pages/registration_page.dart';
// import 'package:flutter_login_ui/pages/splash_screen.dart';
import 'package:graduation_project/core/class/curd.dart';
import 'package:graduation_project/files/resetpass.dart';

// import '../widget/header_widget.dart';
// import 'editpage.dart';
// import 'forgot_password_page.dart';
class profile extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  String username, email, city;
  profile(
      {Key? key,
      required this.username,
      required this.email,
      required this.city,
      required String email1})
      : super(key: key);
  TextEditingController email1 = new TextEditingController();
  Crud _crud = Crud();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 227, 199, 234),
      appBar: AppBar(
        title: Text(
          "     Profile Page ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 162, 79, 194),
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
              ])),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color: Color.fromARGB(255, 255, 255, 255),
              size: _drawerIconSize,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => editpage(email: '',)));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Stack(children: [
        Container(
          height: 100,
          child: HeaderWidget(100, false, Icons.house_rounded),
        ),
        Container(
          height: 150,
          child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          alignment: Alignment.center,
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  GestureDetector(
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                width: 5,
                                color: Color.fromARGB(255, 162, 79, 194)),
                            color: Color.fromARGB(255, 227, 199, 234),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 30,
                                offset: const Offset(5, 5),
                              ),
                            ],
                            // shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 162, 79, 194),
                            size: 80.0,
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding:
                              const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Color.fromARGB(255, 115, 45, 143),
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(
                                  color: Color.fromARGB(255, 162, 79, 194),
                                  width: 5),
                            ),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              leading: Icon(Icons.person,
                                                  size: 33,
                                                  color: Color.fromARGB(
                                                      255, 162, 79, 194)),
                                              title: Text(
                                                'Your name: $username',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),

                                            Divider(
                                              color: Color.fromARGB(
                                                  255, 162, 79, 194),
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.email,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 162, 79, 194)),
                                              title: Text(
                                                ' Your email: $email',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Divider(
                                              color: Color.fromARGB(
                                                  255, 162, 79, 194),
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.my_location,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 162, 79, 194)),
                                              title: Text(
                                                ' Your location: $city',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Divider(
                                              color: Color.fromARGB(
                                                  255, 162, 79, 194),
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),

                                            SizedBox(
                                              height: 15.0,
                                            ),

                                            ListTile(
                                              leading: Icon(Icons.save,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 162, 79, 194)),
                                              title: Text(
                                                'Saved items',
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                // Navigator.push(context, MaterialPageRoute(builder: (context) => SupportPage()));
                                              },
                                            ),
                                            Divider(
                                              color: Color.fromARGB(
                                                  255, 162, 79, 194),
                                              height: 1,
                                            ),
                                            SizedBox(
                                              height: 15.0,
                                            ),

                                            //  Divider(color: Theme.of(context).primaryColor, height: 1,),

                                            SizedBox(
                                              height: 15.0,
                                            ),
                                            ListTile(
                                              leading: Icon(Icons.support,
                                                  size: 30,
                                                  color: Color.fromARGB(
                                                      255, 162, 79, 194)),
                                              title: Text(
                                                'the support',
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onTap: () {
                                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => SupportPage()));
                                              },
                                            ),
                                            Divider(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              height: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ]),
              )
            ],
          ),
        )
      ])),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 162, 79, 194),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                //  Navigator.of(context).push(MaterialPageRoute(
                //   builder: (BuildContext context) => cardpage (email: '', ))
                //   )
                //   ;
              },
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (BuildContext context) => chatpage(email: '',)));
              },
              icon: const Icon(
                Icons.message,
                color: Colors.white,
                size: 35,
              ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => profile(
                          city: '',
                          email: '',
                          username: '',
                          email1: '',
                        )));
              },
              icon: const Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
