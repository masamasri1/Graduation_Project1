import 'package:flutter/material.dart';
import 'package:graduation_project/files/details.dart';
import 'dart:convert';
import 'dart:async';
import 'package:graduation_project/link.dart';
import 'package:http/http.dart' as http;

class cleaningpage extends StatefulWidget {
  final String userName;
  final int jop_id;

  cleaningpage({required this.userName, required this.jop_id});

  // const cleaningpage({Key? key, required this.jop_id}) : super(key: key);

  @override
  _CleaningPageState createState() => _CleaningPageState();
}

class _CleaningPageState extends State<cleaningpage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  Map<int, List<Map<String, dynamic>>> itemsData = {};
  List<Map<String, dynamic>> searchData = [];
  Future<void> fetchData() async {
    try {
      var response = await http.post(
        Uri.parse(applink.show),
        body: {'job_id': widget.jop_id.toString()},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            itemsData = Map.from(responseData['data']).map(
              (key, value) => MapEntry(
                int.parse(key),
                List<Map<String, dynamic>>.from(value),
              ),
            );
          });
        } else {
          // Handle failure
          print('Failed to fetch data: ${responseData['message']}');
        }
      } else {
        // Handle HTTP error
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    }
  }

  Future<void> searchByCity(String city) async {
    try {
      var response = await http.post(
        Uri.parse(applink.search3),
        body: {'craftmen_city': city, 'jop_id': widget.jop_id.toString()},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            searchData = (responseData['data'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
          });
        } else {
          // Handle failure
          print('Failed to fetch data: ${responseData['message']}');
          setState(() {
            searchData = [];
          });
        }
      } else {
        // Handle HTTP error
        print('HTTP error: ${response.statusCode}');
        setState(() {
          searchData = [];
        });
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
      setState(() {
        searchData = [];
      });
    }
  }
// Function isNumber(input) {
//   return !isNaN(parseFloat(input)) && isFinite(input);
// }

  Future<void> searchByPrice(String price) async {
    try {
      var response = await http.post(
        Uri.parse(applink.search1),
        body: {'price': price, 'jop_id': widget.jop_id.toString()},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            searchData = (responseData['data'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
          });
        } else {
          // Handle failure
          print('Failed to fetch data: ${responseData['message']}');
          setState(() {
            searchData = [];
          });
        }
      } else {
        // Handle HTTP error
        print('HTTP error: ${response.statusCode}');
        setState(() {
          searchData = [];
        });
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
      setState(() {
        searchData = [];
      });
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Help'),
          content: Text(
              'Here you can search for the price you want by writing the price, and if there are craftsmen who work in emergency situations, you can write the letter y, also you can search for the city to find the closest craftmen for you .'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> searchByEmergency(String emergency) async {
    try {
      var response = await http.post(
        Uri.parse(applink.search2),
        body: {'emergency': emergency, 'jop_id': widget.jop_id.toString()},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            searchData = (responseData['data'] as List<dynamic>)
                .cast<Map<String, dynamic>>();
          });
        } else {
          // Handle failure
          print('Failed to fetch data: ${responseData['message']}');
        }
      } else {
        // Handle HTTP error
        print('HTTP error: ${response.statusCode}');
      }
    } catch (error) {
      // Handle other errors
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> displayData =
        isSearching ? searchData : itemsData[widget.jop_id] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: "Search here",
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    String input = searchController.text;
                    if (input.isNotEmpty) {
                      if (input == 'Y' ||
                          input == 'y' ||
                          input == 'N' ||
                          input == 'n') {
                        searchByEmergency(input);
                      } else if (isNumeric(input)) {
                        searchByPrice(input);
                      } else {
                        searchByCity(input);
                      }
                      print(input);
                    } else {
                      fetchData();
                    }
                    setState(() {
                      isSearching = input.isNotEmpty;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
                const SizedBox(
                  width: 70,
                ),
                //const Icon(Icons.help_sharp),
                IconButton(
                  icon: Icon(Icons.help_sharp),
                  onPressed: () {
                    _showDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: displayData.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> currentItem = displayData[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 231, 236, 243),
                minimumSize: const Size(80, 60),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              userName: widget.userName,
                              craftmen_id: '${currentItem['user_id']}',
                              user_Name: '${currentItem['user_name']}',
                              craftmenPhone: '${currentItem['craftmen_phone']}',
                              price: '${currentItem['price']}',
                              worksDuringEmergency:
                                  '${currentItem['emergency']}',
                              reservations: [],
                              working_hours: '${currentItem['working_day']}',

                              //duration: '',
                            )));
                // Handle button press, maybe using currentItem for details
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/4128/4128273.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${currentItem['user_name']} | ${currentItem['craftmen_phone']} | ${currentItem['price']} ',
                    style: const TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}
