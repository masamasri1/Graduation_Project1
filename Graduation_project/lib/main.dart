import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive/HoverButton.dart';
import 'package:flutter_responsive/ImageHolder.dart';
import 'package:flutter_responsive/adminlogin.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCepeAfM1Si-WDCFREc0xiIny_0klgxKm4",
          projectId: "onduty-4fea9",
          messagingSenderId: "686579892165",
          appId: "1:686579892165:web:30102a8f596184d30015ac"));

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: Chart(
    //   user: 50,
    //   Worker: 50,
    //   admin: 50,
    // ),
    // home: ChatScreen(),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //main animation driver function
  String f = ("faceboo");
  String g = ("google");
  String i = ("intigram");
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Color color = const Color.fromARGB(255, 49, 190, 212);
  double image1right = 100.0;
  double image2right = -700.0;
  double image3right = -700.0;
  double image4right = -700.0;

  void changer(int a) {
    setState(() {
      if (a == 1) {
        color = const Color.fromARGB(255, 49, 190, 212);
        image1right = 100.0;
        image2right = -700.0;
        image3right = -700.0;
        image4right = -700.0;
      } else if (a == 2) {
        color = const Color.fromARGB(255, 28, 152, 235);
        image1right = -700.0;
        image2right = 100.0;
        image3right = -700.0;
        image4right = -700.0;
      } else if (a == 3) {
        color = const Color.fromARGB(255, 203, 251, 71);
        image1right = -700.0;
        image2right = -700.0;
        image3right = 100.0;
        image4right = -700.0;
      } else if (a == 4) {
        color = const Color.fromARGB(255, 252, 185, 3);
        image1right = -700.0;
        image2right = -700.0;
        image3right = -700.0;
        image4right = 100.0;
      }
    });
  }

  _launchURLF() async {
    const url = 'https://www.facebook.com/';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  _launchURLG() async {
    const url = 'https://www.google.ps/?gws_rd=ssl';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  _launchURLI() async {
    const url = 'https://www.instagram.com/';
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        // Your drawer content goes here
        child: ListView(
          children: <Widget>[
            const DrawerHeader(
              padding: EdgeInsets.only(top: 60),
              child: Text(
                'Contact Us',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
                title: const Text(
                  'Facebook',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                    //  fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  //   Navigator.pop(context);
                  _launchURLF();
                }),
            ListTile(
              title: const Text(
                'Instagram',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  //  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                //   Navigator.pop(context);
                _launchURLI();
              },
            ),
            ListTile(
              title: const Text(
                'Gmail : \n onduty@gmail.com',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  //  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                // Navigator.pop(context);
                _launchURLG();
              },
            ),
            ListTile(
              title: const Text(
                'Phone number: \n 0599528307',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  //  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          //animation part
          Positioned(
              bottom: -100,
              right: -200,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 370),
                curve: Curves.easeIn,
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.height * 0.9,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.height * 0.5)),
              )),

          ImageHolder(
            image: 'img/s.png',
            right: image1right,
          ),
          ImageHolder(
            image: 'img/c.png',
            right: image2right,
          ),
          ImageHolder(
            image: 'img/e.png',
            right: image3right,
          ),
          ImageHolder(
            image: 'img/m.png',
            right: image4right,
          ),

          Positioned(
              bottom: 20,
              right: MediaQuery.of(context).size.width * 0.3,
              child: SizedBox(
                width: 400,
                child: Row(
                  children: [
                    HoverButton(
                      image: 'img/s.png',
                      hover: () {
                        changer(1);
                      },
                    ),
                    HoverButton(
                      image: 'img/c.png',
                      hover: () {
                        changer(2);
                      },
                    ),
                    HoverButton(
                      image: 'img/e.png',
                      hover: () {
                        changer(3);
                      },
                    ),
                    HoverButton(
                      image: 'img/m.png',
                      hover: () {
                        changer(4);
                      },
                    ),
                  ],
                ),
              )),

          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                    //   padding: EdgeInsets.only(left: 30, top: 25, right: 20),
                    height: 80.0,
                    child: const Image(
                      image: AssetImage(
                        "img/ll.png",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const AdminLogin(),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 375),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.only(right: 15.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromARGB(0, 255, 255, 255)),
                            ),
                            child: const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => const MyApp(),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 375),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.only(right: 15.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromARGB(0, 255, 255, 255)),
                            ),
                            child: const Center(
                              child: Text(
                                "Home",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          )),
                      TextButton(
                          onPressed: () {
                            scaffoldKey.currentState?.openDrawer();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 375),
                            curve: Curves.easeInOut,
                            margin: const EdgeInsets.only(right: 15.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                  width: 1.5,
                                  color:
                                      const Color.fromARGB(0, 255, 255, 255)),
                            ),
                            child: const Center(
                              child: Text(
                                "Contact Us",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: Text(
                  "We're here to make your day Easier",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontStyle: FontStyle.italic),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50.0),
                child: Row(
                  children: [
                    Text(
                      "We're",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      "  On Duty",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 50.0, top: 10),
                width: MediaQuery.of(context).size.width * 0.4,
                child: const Text(
                  "Our application collects the largest number of professions in one place and makes it easy for the user to request the service he wants at any time.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
