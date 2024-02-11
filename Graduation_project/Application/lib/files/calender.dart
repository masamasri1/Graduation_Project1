import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
//import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

// class DemoApp extends StatefulWidget {
//   @override
//   _DemoAppState createState() => _DemoAppState();
// }

// class _DemoAppState extends State<DemoApp> {
//   DateTime selectedDay = DateTime.now();
//   late List<CleanCalendarEvent> selectedEvent;

//   final Map<DateTime, List<CleanCalendarEvent>> events = {
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
//       CleanCalendarEvent('Event A',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day, 10, 0),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day, 12, 0),
//           description: 'A special event',
//           color: Colors.blue),
//     ],
//     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
//         [
//       CleanCalendarEvent('Event B',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 10, 0),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 12, 0),
//           color: Colors.orange),
//       CleanCalendarEvent('Event C',
//           startTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 14, 30),
//           endTime: DateTime(DateTime.now().year, DateTime.now().month,
//               DateTime.now().day + 2, 17, 0),
//           color: Colors.pink),
//     ],
//   };

//   void _handleData(date) {
//     setState(() {
//       selectedDay = date;
//       selectedEvent = events[selectedDay] ?? [];
//     });
//     print(selectedDay);
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     selectedEvent = events[selectedDay] ?? [];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calendar'),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Container(
//           child: Calendar(
//             startOnMonday: true,
//             selectedColor: Colors.blue,
//             todayColor: Colors.red,
//             eventColor: Colors.green,
//             eventDoneColor: Colors.amber,
//             bottomBarColor: Colors.deepOrange,
//             onRangeSelected: (range) {
//               print('selected Day ${range.from},${range.to}');
//             },
//             onDateSelected: (date) {
//               return _handleData(date);
//             },
//             events: events,
//             isExpanded: true,
//             dayOfWeekStyle: TextStyle(
//               fontSize: 15,
//               color: Colors.black12,
//               fontWeight: FontWeight.w100,
//             ),
//             bottomBarTextStyle: TextStyle(
//               color: Colors.white,
//             ),
//             hideBottomBar: false,
//             hideArrows: false,
//             weekDays: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
//           ),
//         ),
//       ),
//     );
//   }
// }
class calender extends StatefulWidget {
  @override
  _DateRangePickerDemoState createState() => _DateRangePickerDemoState();
}

class _DateRangePickerDemoState extends State<calender> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Date Time Picker for Start and End')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate =
                    await _showDateTimeRangePicker(context);
                if (selectedDate != null) {
                  setState(() {
                    startDate = selectedDate;
                  });
                }
              },
              child: Text(startDate != null
                  ? 'Start: $startDate'
                  : 'Select Start Date Time'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                DateTime? selectedDate =
                    await _showDateTimeRangePicker(context);
                if (selectedDate != null) {
                  setState(() {
                    endDate = selectedDate;
                  });
                }
              },
              child: Text(
                  endDate != null ? 'End: $endDate' : 'Select End Date Time'),
            ),
          ],
        ),
      ),
    );
  }

  _showDateTimeRangePicker(BuildContext context) async {
    List<DateTime>? dateTimeList = await showOmniDateTimeRangePicker(
      context: context,
      startInitialDate: DateTime.now(),
      startFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      startLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      endInitialDate: DateTime.now(),
      endFirstDate: DateTime(1600).subtract(const Duration(days: 3652)),
      endLastDate: DateTime.now().add(
        const Duration(days: 3652),
      ),
      is24HourMode: false,
      isShowSeconds: false,
      minutesInterval: 1,
      secondsInterval: 1,
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      constraints: const BoxConstraints(
        maxWidth: 350,
        maxHeight: 650,
      ),
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1.drive(
            Tween(
              begin: 0,
              end: 1,
            ),
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: true,
      selectableDayPredicate: (dateTime) {
        // Disable 25th Feb 2023
        if (dateTime == DateTime(2023, 2, 25)) {
          return false;
        } else {
          return true;
        }
      },
    );
    if (dateTimeList != null && dateTimeList.length == 2) {
      setState(() {
        startDate = dateTimeList[0];
        endDate = dateTimeList[1];
      });
    }
  }
}
