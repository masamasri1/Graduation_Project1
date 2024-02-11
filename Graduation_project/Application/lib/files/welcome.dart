// import 'package:flutter/material.dart';
// import 'package:graduation_project/files/login.dart';
// import 'package:graduation_project/files/signup.dart';

// class Welcome extends StatelessWidget {
//   const Welcome({Key? key}) : super(key: key);

//   //@override
//   //State<Welcome> createState() => _MyAppState();

// //class _MyAppState extends State<Welcome> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//           Color.fromARGB(255, 70, 200, 236),
//           Color.fromARGB(255, 76, 155, 207),
//           // Color(0xffb81736),
//           //Color(0xff2b1836),
//         ])),
//         child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 150.0),
//             child: Center(child: Image.asset("images/ll.png")),
//           ),
//           SizedBox(
//             height: 100,
//           ),
//           Text(
//             'welcome',
//             style: TextStyle(
//               fontSize: 30,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => login()));
//             },
//             child: Container(
//               height: 60,
//               width: 350,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(30),
//                   border: Border.all(color: Colors.white)),
//               child: const Center(
//                   child: Text(
//                 'SIGN IN',
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               )),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => signup()));
//             },
//             child: Container(
//               height: 60,
//               width: 350,
//               decoration: BoxDecoration(
//                   //color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   border: Border.all(color: Colors.white)),
//               child: const Center(
//                   child: Text(
//                 'SIGN UP',
//                 style: TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               )),
//             ),
//           ),
//           Spacer(),
//           // Text(
//           //"Log in with social media",
//           // style: TextStyle(
//           //  fontSize: 30,
//           // fontWeight: FontWeight.bold,
//           // color: Colors.white,
//           //),
//           //)
//         ]),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:graduation_project/files/login.dart';
import 'package:graduation_project/files/signup.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 70, 200, 236),
              Color.fromARGB(255, 76, 155, 207),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("images/ll.png"),
              SizedBox(height: 30),
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.blue,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => signup()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  side: BorderSide(color: Colors.white, width: 2),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
