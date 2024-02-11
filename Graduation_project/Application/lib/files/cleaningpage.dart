// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:graduation_project/link.dart';
// import 'package:graduation_project/core/class/curd.dart';
// import 'package:flutter/src/rendering/box.dart';
// import 'package:http/http.dart' as http;

// class cleaningpage extends StatefulWidget {
//   final int jop_id;

//   const cleaningpage({Key? key, required this.jop_id}) : super(key: key);

//   @override
//   _CleaningPageState createState() => _CleaningPageState();
// }

// class _CleaningPageState extends State<cleaningpage> {
//   Crud _crud = Crud();
//   bool issearching = false;
//   final user_name = TextEditingController();
//   final phone = TextEditingController();
//   final price = TextEditingController();
//   final work = TextEditingController();
//   final SearchController = TextEditingController();
//   final emergency = TextEditingController();
//   // List<Map<String, dynamic>> _userData = [];
//   TextEditingController search = TextEditingController();

//   Future<List<Map<String, dynamic>>> fetchItems() async {
//     var result = await _crud.postRequest(applink.show, {
//       'user_name': user_name.text,
//       'craftmen_phone': phone.text,
//       'price': price.text,
//       'working_day': work.text,
//       'jop_id': widget.jop_id.toString(),
//       'emergency': emergency.text,
//       // <-- Use jobId here
//     });

//     // Handle the result based on your current logic...
//     // (the below logic is based on your initial code, adjust as needed)
//     if (result is! Map<String, dynamic>) {
//       print("Invalid response format");
//       return []; // return an empty list
//     }

//     Map<String, dynamic> response = result;

//     if (response['status'] == "success") {
//       if (response.containsKey('data') && response['data'] is List) {
//         List<Map<String, dynamic>> data =
//             List<Map<String, dynamic>>.from(response['data']);
//         return data;
//       } else {
//         print("Unexpected data format");
//         return [];
//       }
//     } else {
//       print("Server responded with: ${response['message'] ?? 'Unknown error'}");
//       return [];
//     }
//   }

//   Future<List<Map<String, dynamic>>> se([String price = ""]) async {
//     var result = await _crud.postRequest(applink.search1, {
//       //'user_name': user_name.text,
//       //'craftmen_phone': phone.text,
//       'price': price,
//       //'working_day': work.text,
//       //'jop_id': widget.jop_id.toString(),
//       //'emergency': emergency.text,
//       // <-- Use jobId here
//     });

//     // Handle the result based on your current logic...
//     // (the below logic is based on your initial code, adjust as needed)
//     if (result is! Map<String, dynamic>) {
//       print("Invalid response format");
//       return []; // return an empty list
//     }

//     Map<String, dynamic> response = result;

//     if (response['status'] == "success") {
//       if (response.containsKey('data') && response['data'] is List) {
//         List<Map<String, dynamic>> data =
//             List<Map<String, dynamic>>.from(response['data']);
//         return data;
//       } else {
//         print("Unexpected data format");
//         return [];
//       }
//     } else {
//       print("Server responded with: ${response['message'] ?? 'Unknown error'}");
//       return [];
//     }
//   }

//   List<Map<String, dynamic>> searchResults = [];

//   bool isSearching = false;

//   Future<void> searchbyprice(String price) async {
//     var response =
//         await http.post(Uri.parse(applink.search1), body: {'price': price});
//     // print(response.toString());
//     if (response.statusCode == 200) {
//       Map<String, dynamic> responseData = json.decode(response.body);

//       if (responseData['status'] == 'success') {
//         setState(() {
//           List<Map<String, dynamic>> data =
//               List<Map<String, dynamic>>.from(responseData['data']);
//         });
//       } else {
//         // Handle failure
//         print('Failed to fetch data: ${responseData['message']}');
//       }
//     } else {
//       // Handle HTTP error
//       print('HTTP error: ${response.statusCode}');
//     }
//   }

//   Future<void> searchbyeme(String emergency) async {
//     var response = await http
//         .post(Uri.parse(applink.search2), body: {'emergency': emergency});
//     // print(response.toString());
//     if (response.statusCode == 200) {
//       Map<String, dynamic> responseData = json.decode(response.body);

//       if (responseData['status'] == 'success') {
//         setState(() {
//           List<Map<String, dynamic>> data =
//               List<Map<String, dynamic>>.from(responseData['data']);
//         });
//       } else {
//         // Handle failure
//         print('Failed to fetch data: ${responseData['message']}');
//       }
//     } else {
//       // Handle HTTP error
//       print('HTTP error: ${response.statusCode}');
//     }
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Row(
//   //         children: [
//   //           Expanded(
//   //               child: TextField(
//   //             controller: SearchController,
//   //             decoration: InputDecoration(
//   //               hintText: "Search here",
//   //             ),
//   //           )),
//   //           Row(
//   //             children: [
//   //               IconButton(
//   //                   onPressed: () async {
//   //                     if (isSearching) {
//   //                       String title = SearchController.text;

//   //                       se();
//   //                     }
//   //                     setState(() {
//   //                       // if (SearchController.text == 'Y' ||
//   //                       //     SearchController.text == 'y') {
//   //                       //   searchbyeme(SearchController.text);
//   //                       //   print(SearchController.text);
//   //                       // } else {
//   //                       //   searchbyprice(SearchController.text);
//   //                       //   print(SearchController.text);
//   //                       // }

//   //                       // searchbyname(SearchController.text) ;
//   //                       //           print(SearchController.text);
//   //                       this.isSearching = !this.isSearching;
//   //                     });
//   //                   },
//   //                   icon: Icon(Icons.search)),
//   //               SizedBox(
//   //                 width: 70,
//   //               ),
//   //               Icon(Icons.notifications),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     body: FutureBuilder<List<Map<String, dynamic>>>(
//   //       future: fetchItems(),
//   //       builder: (context, snapshot) {
//   //         if (snapshot.connectionState == ConnectionState.done) {
//   //           if (snapshot.hasError) {
//   //             return Center(child: Text('Error: ${snapshot.error}'));
//   //           }

//   //           final items = snapshot.data;

//   //           return ListView.builder(
//   //             itemCount: items?.length,
//   //             itemBuilder: (context, index) {
//   //               return Padding(
//   //                 padding: const EdgeInsets.all(8.0),
//   //                 child: ElevatedButton(
//   //                   style: ElevatedButton.styleFrom(
//   //                     primary: Color.fromARGB(255, 122, 156, 203),
//   //                     minimumSize: Size(80, 60),
//   //                   ),
//   //                   onPressed: () {
//   //                     // Handle button press, maybe using items[index] for details
//   //                   },
//   //                   child: Row(
//   //                     children: [
//   //                       Padding(
//   //                         padding: const EdgeInsets.all(8.0),
//   //                         child: CircleAvatar(
//   //                           radius: 20, // Adjust the size as needed
//   //                           backgroundImage: NetworkImage(
//   //                             'https://cdn-icons-png.flaticon.com/512/4128/4128273.png', // Provide the URL to the person's photo
//   //                           ),
//   //                         ),
//   //                       ),
//   //                       //Icon(Icons.person, color: Colors.black),
//   //                       SizedBox(width: 8),
//   //                       Text(
//   //                         '${items?[index]['user_name']} | ${items?[index]['emergency']} | ${items?[index]['price']}', // | ${items?[index]['craftmen_phone']} | ${items?[index]['working_day']}',
//   //                         style: TextStyle(color: Colors.black),
//   //                       ),
//   //                     ],
//   //                   ),
//   //                 ),
//   //               );
//   //             },
//   //           );
//   //         } else {
//   //           return Center(child: CircularProgressIndicator());
//   //         }
//   //       },
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     List<Map<String, dynamic>> displayData =
//         isSearching ? searchData : itemsData;

//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             Expanded(
//               child: TextField(
//                 controller: searchController,
//                 decoration: const InputDecoration(
//                   hintText: "Search here",
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () async {
//                     String input = searchController.text;
//                     if (input.isNotEmpty) {
//                       if (input == 'Y' ||
//                           input == 'y' ||
//                           input == 'N' ||
//                           input == 'n') {
//                         searchByEmergency(input);
//                       } else {
//                         searchByPrice(input);
//                       }
//                       print(input);
//                     } else {
//                       fetchData();
//                     }
//                     setState(() {
//                       isSearching = input.isNotEmpty;
//                     });
//                   },
//                   icon: const Icon(Icons.search),
//                 ),
//                 const SizedBox(
//                   width: 70,
//                 ),
//                 const Icon(Icons.notifications),
//               ],
//             ),
//           ],
//         ),
//       ),
//       body: ListView.builder(
//         itemCount: displayData.length,
//         itemBuilder: (context, index) {
//           Map<String, dynamic> currentItem = displayData[index];
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: const Color.fromARGB(255, 231, 236, 243),
//                 minimumSize: const Size(80, 60),
//               ),
//               onPressed: () {
//                 // Handle button press, maybe using currentItem for details
//               },
//               child: Row(
//                 children: [
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundImage: NetworkImage(
//                         'https://cdn-icons-png.flaticon.com/512/4128/4128273.png',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Text(
//                     '${currentItem['user_name']} | ${currentItem['emergency']} | ${currentItem['price']}',
//                     style: const TextStyle(color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

