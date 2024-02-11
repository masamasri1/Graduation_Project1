import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:graduation_project/files/details.dart';
import 'package:graduation_project/link.dart';

class BookingPage extends StatefulWidget {
  final String craftmen_id;
  final String userName;
  BookingPage({
    required this.craftmen_id,
    required this.userName,
  });

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController craftsmanIdController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController durationController =
      TextEditingController(); // New controller

  @override
  void initState() {
    super.initState();
    getUserID();
    getFCMToken();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startDateController.text =
        "${startDate.toLocal()} ${startTime.format(context)}";
    endDateController.text = "${endDate.toLocal()} ${endTime.format(context)}";
  }

  String start_date = '';
  String end_date = '';
  String craftsman_id = '';
  String user_id = '';
  String name = '';
  String duration = '';

  DateTime startDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  DateTime endDate = DateTime.now();
  TimeOfDay endTime = TimeOfDay.now();

  String userId = "";

  Future<void> getUserID() async {
    try {
      var response = await http.post(
        Uri.parse(applink.id),
        body: {'user_name': widget.userName},
      );

      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body);
        setState(() {
          userId = userData['user_id'].toString();
          print(userId);
        });
      } else {
        print('Error fetching user_id: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void getFCMToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? fcmToken = await messaging.getToken();
    print('FCM Token: $fcmToken');
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        startDateController.text = "${startDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
        endDateController.text = "${endDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime initialDateTime = endDate ?? currentDate;

    // Show date picker to select the date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Show time picker to select the time
      TimeOfDay initialTime = TimeOfDay.fromDateTime(initialDateTime);
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        // Combine the selected date and time
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          endDate = selectedDateTime;
          endDateController.text = "${endDate.toLocal()}";
        });
      }
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );

    if (picked != null && picked != startTime) {
      setState(() {
        startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );

    if (picked != null && picked != endTime) {
      setState(() {
        endTime = picked;
      });
    }
  }

  // Future<void> _bookReservation() async {
  //   var url = Uri.parse(applink.book);

  //   var response = await http.post(
  //     url,
  //     body: {
  //       'start_date': startDateController.text,
  //       'end_date': endDateController.text,
  //       'craftmen_id': widget.craftmen_id,
  //       'user_id': userId,
  //       'duration': durationController.text,
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     print('Reservation successfully saved');
  //     _sendFCMTokenToServer();

  //     // Calculate the duration in hours between start and end dates/times
  //     DateTime startDateTime = DateTime(
  //       startDate.year,
  //       startDate.month,
  //       startDate.day,
  //       startTime.hour,
  //       startTime.minute,
  //     );
  //     DateTime endDateTime = DateTime(
  //       endDate.year,
  //       endDate.month,
  //       endDate.day,
  //       endTime.hour,
  //       endTime.minute,
  //     );
  //     int durationInHours = endDateTime.difference(startDateTime).inHours;

  //     // Set the result in the durationController
  //     durationController.text = '$durationInHours hours';

  //     // Return to the original page
  //     Navigator.pop(context);
  //   } else {
  //     print('Error: ${response.body}');
  //   }
  // }

  Future<void> _bookReservation() async {
    // Calculate the duration in hours between start and end dates/times
    DateTime startDateTime = DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
    DateTime endDateTime = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );
    int durationInHours = endDateTime.difference(startDateTime).inHours;

    // Set the result in the durationController
    durationController.text = '$durationInHours hours';

    // Now, you can send the reservation request to the server
    var url = Uri.parse(applink.book);

    var response = await http.post(
      url,
      body: {
        'start_date': startDateController.text,
        'end_date': endDateController.text,
        'craftmen_id': widget.craftmen_id,
        'user_id': userId,
        'duration': durationController.text, // Use the calculated duration
      },
    );

    if (response.statusCode == 200) {
      print('Reservation successfully saved');
      _sendFCMTokenToServer();

      // Return to the original page
      Navigator.pop(context);
    } else {
      print('Error: ${response.body}');
    }
  }

  Future<void> _sendFCMTokenToServer() async {
    var notificationUrl = Uri.parse(applink.sendNotification);

    try {
      var response = await http.post(
        notificationUrl,
        body: {
          'craftsmen_id': widget.craftmen_id,
          'fcm_token':
              'ds2JOj4-S-S6Gpup70gYoT:APA91bHmxgTdwTLHiZ36gjKLTZpm7EpbfyCZ3RQ_WGIfAEg7Rj3rpvGmaL4yOcWxqlRay6POywyPU4mpHvXeBJghdIhpME_U2PWYJc1PQs3lM7mpc6AuI0ZwOxWN73uJ2AFKjMKhkxAm',
          'message': 'New reservation made!',
        },
      );

      if (response.statusCode == 200) {
        print('FCM Token sent to server successfully');
      } else {
        print('Error sending FCM Token to server: ${response.body}');
      }
    } catch (e) {
      print('Error sending FCM Token to server: $e');
    }
  }

  Future<void> _selectStartDateTime(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime initialDateTime = startDate ?? currentDate;

    // Show date picker to select the date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDateTime,
      firstDate: currentDate,
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Show time picker to select the time
      TimeOfDay initialTime = TimeOfDay.fromDateTime(initialDateTime);
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        // Combine the selected date and time
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        setState(() {
          startDate = selectedDateTime;
          startDateController.text = "${startDate.toLocal()}";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text('Select Start Date:'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectStartDateTime(context),
                    child: Text(
                      "${startDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text('Select End Date:'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextButton(
                    onPressed: () => _selectEndDateTime(context),
                    child: Text(
                      "${endDate.toLocal()}".split(' ')[0],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _bookReservation();
              },
              child: Text('Book Now'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: durationController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Duration',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
