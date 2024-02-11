import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/files/booking.dart';
import 'package:graduation_project/files/cleaningpage.dart';
import 'package:graduation_project/files/crafts.dart';
import 'package:graduation_project/files/details.dart';
import 'package:graduation_project/files/pro.dart';
import 'package:graduation_project/files/profilecraft.dart';
import 'package:graduation_project/files/welcome.dart';
import 'package:graduation_project/files/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // String? fcmToken = await FirebaseMessaging.instance.getToken();

  // // Use fcmToken as needed (e.g., store it in your database)
  // print('FCM Token: $fcmToken');

  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  // messaging.onTokenRefresh.listen((String? token) {
  //   print('FCM Token (onTokenRefresh): $token');
  // });

  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Welcome(),
//       routes: {
//         "welcome": (context) => Welcome(),
//       },
//     );
//   }
// }
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
      routes: {
        "welcome": (context) => Welcome(),
      },
    );
  }
}
