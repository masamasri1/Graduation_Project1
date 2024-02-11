import 'package:flutter/material.dart';
import 'package:graduation_project/link.dart';
import 'package:graduation_project/main.dart';
import 'package:http/http.dart' as http;
//import 'package:paypal_integration_app/main.dart';

class StarRatingBar extends StatefulWidget {
  StarRatingBar({Key? key, required this.craftmen_id, required this.user_id})
      : super(key: key);
  late final String craftmen_id;
  late final String user_id;

  @override
  _StarRatingBarState createState() => _StarRatingBarState();
}

class _StarRatingBarState extends State<StarRatingBar> {
  double _rating = 0;
  TextEditingController _commentController = TextEditingController();

  void _submitRating() async {
    final response = await http.post(
      Uri.parse(applink.rate),
      body: {
        'user_id': widget.user_id,
        'craftmen_id': widget.craftmen_id,
        'rating': _rating.toString(),
        'comment': _commentController.text,
      },
    );

    if (response.statusCode == 200) {
      // Rating submitted successfully
      print(_commentController.text);
      print(_rating);
      print(widget.craftmen_id);
      print(widget.user_id);
      print('Rating submitted successfully');
    } else {
      // Handle error
      print('Error submitting rating');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Star Rating Bar Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Rating: $_rating'),
            SizedBox(height: 20),
            // Star Rating Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0;
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 20),
            // Comment Text Field
            SizedBox(
              height: 150,
              width: 250,
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  labelText: 'Enter your comment',
                ),
              ),
            ),
            // SizedBox(height: 20),
            // Save Rating Button
            ElevatedButton(
              onPressed: () {
                _submitRating();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyApp(),
                  ),
                );
              },
              child: Text('Save Rating'),
            ),
          ],
        ),
      ),
    );
  }
}
