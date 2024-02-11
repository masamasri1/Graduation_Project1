import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/files/rate.dart';
import 'package:graduation_project/main.dart';
import 'package:graduation_project/link.dart';
//import 'package:graduation_project/edituserprofile.dart';
import 'package:http/http.dart' as http;

//...........................................................................
// import 'package:flutter/material.dart';
// import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

// class CheckoutPage extends StatefulWidget {
//   const CheckoutPage({super.key});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   @override
//   void initState() {
//     super.initState();
//     _initPayPalCheckout();
//   }

//   _initPayPalCheckout() async {
//     // Your PayPal checkout logic here
//     try {
//       await Navigator.of(context).push(MaterialPageRoute(
//         builder: (BuildContext context) => PaypalCheckout(
//           sandboxMode: true,
//           clientId:
//               "AQIKSCl3oNAc-bMMFVdayjk3J6gvbNlMfU5igbHUeW1cxRnjcZWbXi0P0K9eWAKvwBrtWnOjf2dyM7v6",
//           secretKey:
//               "EGx8yao9kv20-VcEcTxk-NC44w5DoPDbFUQ4FVTXrIFXzsY6TV7chpIfbfSrOvB4xWJh1uKtQGMI6sek",
//           returnURL: "success.snippetcoder.com",
//           cancelURL: "cancel.snippetcoder.com",
//           transactions: const [
//             {
//               "amount": {
//                 "total": '70',
//                 "currency": "USD",
//                 "details": {
//                   "subtotal": '70',
//                   "shipping": '0',
//                   "shipping_discount": 0
//                 }
//               },
//               "description": "The payment transaction description.",
//               "item_list": {
//                 "items": [
//                   {
//                     "name": "Apple",
//                     "quantity": 4,
//                     "price": '5',
//                     "currency": "USD"
//                   },
//                   {
//                     "name": "Pineapple",
//                     "quantity": 5,
//                     "price": '10',
//                     "currency": "USD"
//                   }
//                 ],
//               }
//             }
//           ],
//           note: "Contact us for any questions on your order.",
//           onSuccess: (Map params) async {
//             print("onSuccess: $params");
//           },
//           onError: (error) {
//             print("onError: $error");
//             Navigator.pop(context);
//           },
//           onCancel: () {
//             print('cancelled:');
//           },
//         ),
//       ));
//     } catch (e) {
//       print('Error initializing PayPal checkout: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "PayPal Checkout",
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//       body: Center(
//         child: const Text(
//           'Initializing PayPal Checkout...',
//           style: TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool paymentSuccess = false;
//   void makefalse() {
//     paymentSuccess = false;
//   }

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           if (!paymentSuccess)
//             TextButton(
//                 onPressed: () => {
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (BuildContext context) => PaypalCheckout(
//                               sandboxMode: true,
//                               clientId:
//                                   "AW1TdvpSGbIM5iP4HJNI5TyTmwpY9Gv9dYw8_8yW5lYIbCqf326vrkrp0ce9TAqjEGMHiV3OqJM_aRT0",
//                               secretKey:
//                                   "EHHtTDjnmTZATYBPiGzZC_AZUfMpMAzj2VZUeqlFUrRJA_C0pQNCxDccB5qoRQSEdcOnnKQhycuOWdP9",
//                               returnURL: "https://samplesite.com/return",
//                               cancelURL: "https://samplesite.com/cancel",
//                               transactions: const [
//                                 {
//                                   "amount": {
//                                     "total": '1',
//                                     "currency": "USD",
//                                     "details": {
//                                       "subtotal": '1',
//                                       "shipping": '0',
//                                       "shipping_discount": 0
//                                     }
//                                   },
//                                   "description":
//                                       "The payment transaction description.",
//                                   // "payment_options": {
//                                   //   "allowed_payment_method":
//                                   //       "INSTANT_FUNDING_SOURCE"
//                                   // },
//                                   "item_list": {
//                                     "items": [
//                                       {
//                                         "name": "A demo product",
//                                         "quantity": 1,
//                                         "price": '1',
//                                         "currency": "USD"
//                                       }
//                                     ],

//                                     // shipping address is not required though
//                                     // "shipping_address": {
//                                     //   "recipient_name": "Jane Foster",
//                                     //   "line1": "Travis County",
//                                     //   "line2": "",
//                                     //   "city": "Austin",
//                                     //   "country_code": "US",
//                                     //   "postal_code": "73301",
//                                     //   "phone": "+00000000",
//                                     //   "state": "Texas"
//                                     // },
//                                   }
//                                 }
//                               ],
//                               note:
//                                   "Contact us for any questions on your order.",
//                               onSuccess: (Map params) async {
//                                 setState(() {
//                                   paymentSuccess = true;
//                                 });
//                               },
//                               onError: (error) {
//                                 print("onError: $error");

//                                 //    Fluttertoast.showToast(msg: "Error");
//                               },
//                               onCancel: (params) {
//                                 print('cancelled: $params');
//                               }),
//                         ),
//                       ),
//                     },
//                 child: const Text("Make Payment"))
//           else
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16),
//                   color: Colors.blue,
//                   child: Text(
//                     "Done",
//                     style:
//                         TextStyle(color: const Color.fromARGB(255, 11, 11, 11)),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => MyApp(),
//                       ),
//                     );
//                   },
//                   child: Text("Go Back"),
//                 ),
//               ],
//             ),
//         ],
//       )),
//     );
//   }
// }
// //.,,,,,,,mmmmkmkk
class MyHomePage extends StatefulWidget {
  MyHomePage(
      {Key? key,
      required this.title,
      required this.price,
      required this.duration,
      required this.craftmen_id,
      required this.user_id,
      required this.reid})
      : super(key: key);
  final String title;
  final String price;
  final String duration;
  final String craftmen_id;
  final String user_id;
  final String reid;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool paymentSuccess = false;
  Future<void> sendPaymentToCraftsman(double totalPrice) async {
    try {
      // Replace 'YOUR_PAYMENT_API_ENDPOINT' with the actual endpoint on your server
      var response = await http.post(
        Uri.parse('YOUR_PAYMENT_API_ENDPOINT'),
        body: {
          'craftsman_id':
              widget.craftmen_id, // Replace with the actual craftsman's ID
          'total_price': totalPrice.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Payment request sent successfully
        print('Payment request sent to craftsman');
      } else {
        // Handle error
        print(
            'Failed to send payment request to craftsman: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }

  Future<void> deleteReservation() async {
    try {
      var response = await http.post(
        Uri.parse(applink.rdelete),
        body: {'res_id': widget.reid},
      );
      //print(reid);
      if (response.statusCode == 200) {
        // Successful deletion
        print("Reservation deleted successfully");
        //ReservationData(); // Implement a function to fetch updated reservation data
      } else {
        // Handle error
        print("Failed to delete reservation: ${response.reasonPhrase}");
        // Optionally, show a snackbar or dialog to inform the user about the error
      }
    } catch (error) {
      // Handle network or other errors
      print("Error: $error");
      // Optionally, show a snackbar or dialog to inform the user about the error
    }
  }

  double calculateTotal(double price, double duration) {
    // Assuming that 'price' and 'duration' are in String format
    price = double.parse(widget.price);
    duration = double.parse(widget.duration);
    return price * duration;
  }

  void makefalse() {
    paymentSuccess = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!paymentSuccess)
            TextButton(
                onPressed: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) => PaypalCheckout(
                              sandboxMode: true,
                              clientId:
                                  //  "Ab4neIi0v0xRt-2Gzb_BDujrl8oBGdQyvUy-I8ZYoCaRY57f9k9vCS1t5Bs9P8v9PWp2zcmNKtUjgGys",
                                  "AVy0695lXrj02JBwfJVU59lR-V1kyY1gDENQvPYAe-QKYxGpa_GdcqcVukiNzUExQns3qxsxWmv9WmGb",
                              secretKey:
                                  //"EAb26YnTm0KWxE0T8iH1ck9iFIXshPpC2_pxAfBMwsLdoCK05SgHcbSqHDVqxEZ9HbGSHafN0XABrLWx",
                                  "EKgbqMy-EEQ8SHNRzlU4x_GCUDIThjZkwLhf53eIzF_qJ10FdhI-8X0eirc_9EENlDkR1ZS6b24H7txA",
                              returnURL: "success.snippetcoder.com",
                              cancelURL: "cancel.snippetcoder.com",
                              transactions: const [
                                {
                                  "amount": {
                                    "total": '1',
                                    "currency": "USD",
                                    "details": {
                                      "subtotal": '1',
                                      "shipping": '0',
                                      "shipping_discount": 0
                                    }
                                  },
                                  "description":
                                      "The payment transaction description.",
                                  "payment_options": {
                                    "allowed_payment_method":
                                        "INSTANT_FUNDING_SOURCE"
                                  },
                                  "item_list": {
                                    "items": [
                                      {
                                        "name": "A demo product",
                                        "quantity": 1,
                                        "price": '1',
                                        "currency": "USD"
                                      }
                                    ],

                                    // shipping address is not required though
                                    // "shipping_address": {
                                    //   "recipient_name": "Jane Foster",
                                    //   "line1": "Travis County",
                                    //   "line2": "",
                                    //   "city": "Austin",
                                    //   "country_code": "US",
                                    //   "postal_code": "73301",
                                    //   "phone": "+00000000",
                                    //   "state": "Texas"
                                    // },
                                  }
                                }
                              ],
                              note:
                                  "Contact us for any questions on your order.",
                              onSuccess: (Map params) async {
                                // double duration = widget.duration
                                //     as double; // Update with the actual duration from your reservation
                                // double craftsmanPrice = widget.price
                                //     as double; // Update with the actual craftsman price

                                // double totalPrice =
                                //     calculateTotal(duration, craftsmanPrice);

                                // Send payment request to craftsman
                                // await sendPaymentToCraftsman(totalPrice);
                                Fluttertoast.showToast(
                                    msg: 'Payment successful.');

                                // Send notification to craftsman
                                sendNotificationToCraftsman();
                                deleteReservation();
                                setState(() {
                                  paymentSuccess = true;
                                });
                              },
                              onError: (error) {
                                print("onError: $error");

                                //    Fluttertoast.showToast(msg: "Error");
                              },
                              onCancel: (params) {
                                print('cancelled: $params');
                              }),
                        ),
                      ),
                    },
                child: const Text("Make Payment"))
          else
            Column(
              children: [
                Text(
                  "Payment Done Successfully",
                  style: TextStyle(
                    color: Color.fromARGB(
                        255, 55, 176, 237), // Set the color to green
                    fontSize: 18.0, // Adjust the font size if needed
                    fontWeight:
                        FontWeight.bold, // Optional: Add bold font weight
                  ),
                ),
                Image(
                  image: AssetImage("lib/icon/giphy.gif"),
                  width: 320,
                  height: 320,
                ),
                ElevatedButton(
                  onPressed: () {
                    print("done");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StarRatingBar(
                            craftmen_id: widget.craftmen_id,
                            user_id: widget.user_id),
                      ),
                    );
                  },
                  child: Text("Done"),
                ),
              ],
            ),
        ],
      )),
    );
  }

  Future<void> sendNotificationToCraftsman() async {
    try {
      // Replace 'YOUR_NOTIFICATION_SERVICE_ENDPOINT' with the actual endpoint on your server
      var response = await http.post(
        Uri.parse(applink.paynot),
        body: {
          'fcm_token':
              'ds2JOj4-S-S6Gpup70gYoT:APA91bHmxgTdwTLHiZ36gjKLTZpm7EpbfyCZ3RQ_WGIfAEg7Rj3rpvGmaL4yOcWxqlRay6POywyPU4mpHvXeBJghdIhpME_U2PWYJc1PQs3lM7mpc6AuI0ZwOxWN73uJ2AFKjMKhkxAm',
          'craftsman_id': widget.craftmen_id,
          'message': 'You have received a payment.',
        },
      );

      if (response.statusCode == 200) {
        // Notification sent successfully
        print('Notification sent to craftsman');
      } else {
        // Handle error
        print(
            'Failed to send notification to craftsman: ${response.reasonPhrase}');
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
    }
  }
}
