import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/core/class/curd.dart';
import 'package:graduation_project/files/cleaningpage.dart';
import 'package:graduation_project/files/crafts.dart';
import 'package:graduation_project/files/pro.dart';
import 'package:graduation_project/files/welcome.dart';
import 'package:graduation_project/files/login.dart';

// import 'package:flutter/material.dart';

// class EditProfilePage extends StatefulWidget {
//   @override
//   _EditProfilePageState createState() => _EditProfilePageState();
// }

// class _EditProfilePageState extends State<EditProfilePage> {
//   TextEditingController userNameController = TextEditingController();
//   TextEditingController gmailController = TextEditingController();
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//   TextEditingController cityController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Profile'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: userNameController,
//               decoration: InputDecoration(
//                 labelText: 'User Name',
//                 labelStyle: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextField(
//               controller: gmailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextField(
//               controller: phoneNumberController,
//               decoration: InputDecoration(
//                 labelText: 'Phone Number',
//                 labelStyle: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextField(
//               controller: passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextField(
//               controller: confirmPasswordController,
//               decoration: InputDecoration(
//                 labelText: 'Confirm Password',
//                 labelStyle: TextStyle(color: Colors.blue),
//               ),
//             ),
//             TextField(
//               controller: cityController,
//               decoration: InputDecoration(
//                 labelText: 'City',
//                 labelStyle: TextStyle(color: Colors.blue),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Add your logic here to send the updated user data to the server
//                 // You can use the controllers to get the user input
//               },
//               child: Text(
//                 'Save',
//                 style: TextStyle(color: Colors.white),
//               ),
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all(Colors.blue),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: EditProfilePage(),
//   ));
// }
import 'package:flutter/material.dart';
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

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController gmailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  // TextEditingController user_id = TextEditingController();
  Crud _crud = Crud();

  // Future getData() async {
  //   user us = user(
  //       user_id.toString(),
  //       userNameController.text.trim(),
  //       gmailController.text.trim(),
  //       phoneNumberController.text.trim(),
  //       passwordController.text.trim(),
  //       confirmPasswordController.text.trim(),
  //       cityController.text.trim());
  //   try {
  //     var res = await http.post(Uri.parse(applink.edit), body: {
  //       // 'user_id': us.user_id,
  //       // 'user_name': userNameController.text.trim(),
  //       // 'gamil': gmailController.text.trim(),
  //       // 'phone_number': phoneNumberController.text.trim(),
  //       // 'password': passwordController.text.trim(),
  //       // 'cpassword': confirmPasswordController.text.trim(),
  //       // 'city': cityController.text.trim(),
  //       us.toJson(),
  //     });

  //     if (res.statusCode == 200) {
  //       var en = jsonDecode(res.body);
  //       if (en['status'] == "success") {
  //         Fluttertoast.showToast(msg: "Success");
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     crafts(userName: userNameController.text)));
  //       } else {
  //         Fluttertoast.showToast(msg: "Try again");
  //       }
  //     }
  //   } catch (e) {
  //     print("Error decoding JSON: $e");
  //   }
  // }
  Future handleEdit() async {
    final response = await http.post(
      Uri.parse(applink.edit),
      body: {
        'user_name': userNameController.text,
        'gmail': gmailController.text,
        'phone_number': phoneNumberController.text,
        'password': passwordController.text,
        'cpassword': confirmPasswordController.text,
        'city': cityController.text,
      },
    );

    if (response.statusCode == 200) {
      // Handle the response from the PHP script, which can include success or error messages.
      print(response.body);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => crafts(userName: userNameController.text)));
      // You can navigate to a different screen or show a success message here.
    } else {
      // Handle the HTTP request error.
      print("HTTP Error: ${response.statusCode}");
    }
  }

  // void handleEdit(Map<String, dynamic> user) async {
  //   try {
  //     var res = await http.post(
  //       Uri.parse(applink.edit),
  //       body: {
  //         'user_id': user['user_id'].toString(),
  //         'user_name': userNameController.text,
  //         'gmail': gmailController.text,
  //         'phone_number': phoneNumberController.text,
  //         'password': passwordController.text,
  //         'cpassword': confirmPasswordController.text,
  //         'city': cityController.text,
  //       },
  //     );
  //     print(user['user_id'].toString());
  //     if (res.statusCode == 200) {
  //       var en = jsonDecode(res.body);
  //       if (en['status'] == "success") {
  //         // Successful update
  //         print("User updated successfully");
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     crafts(userName: userNameController.text)));
  //         // fetchData();
  //       } else {
  //         // Handle error
  //         print("Failed to update user: ${res.reasonPhrase}");
  //       }
  //     } else {
  //       print("Failed to update user");
  //     }
  //   } catch (error) {
  //     // Handle network or other errors
  //     print("Error: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color.fromARGB(255, 70, 200, 236),
          //       Color.fromARGB(255, 76, 155, 207),
          //     ],
          //   ),
          // ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildRoundedTextField(
                  controller: userNameController,
                  labelText: 'User Name',
                ),
                SizedBox(
                  height: 25,
                ),
                _buildRoundedTextField(
                  controller: gmailController,
                  labelText: 'Email',
                ),
                SizedBox(
                  height: 25,
                ),
                _buildRoundedTextField(
                  controller: phoneNumberController,
                  labelText: 'Phone Number',
                ),
                SizedBox(
                  height: 25,
                ),
                _buildRoundedTextField(
                  controller: passwordController,
                  labelText: 'Password',
                ),
                SizedBox(
                  height: 25,
                ),
                _buildRoundedTextField(
                  controller: confirmPasswordController,
                  labelText: 'Confirm Password',
                ),
                SizedBox(
                  height: 25,
                ),
                _buildRoundedTextField(
                  controller: cityController,
                  labelText: 'City',
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Map<String, dynamic> userData = {
                    //   'user_id': user_id, // Replace with the actual user ID

                    //   'user_name': userNameController.text,
                    //   'gmail': gmailController.text,
                    //   'phone_number': phoneNumberController.text,
                    //   'password': passwordController.text,
                    //   'cpassword': confirmPasswordController.text,
                    //   'city': cityController.text,
                    // };

                    // // Call the handleEdit function
                    handleEdit();

                    // Add your logic here to send the updated user data to the server
                    // You can use the controllers to get the user input
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedTextField({
    required TextEditingController controller,
    required String labelText,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 70, 200, 236),
            Color.fromARGB(255, 76, 155, 207),
          ],
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        onChanged: (value) {},
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white),
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
