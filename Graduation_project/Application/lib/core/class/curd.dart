// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Crud {
//   getRequest(String url) async {
//     try {
//       var response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         var responsebody = jsonDecode(response.body);
//         return responsebody;
//       } else {
//         print("Error ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error catch $e");
//     }
//   }

//   postRequest(String url, Map data) async {
//     try {
//       var response = await http.post(Uri.parse(url), body: data);
//       if (response.statusCode == 200) {
//         var responsebody = jsonDecode(response.body);
//         return responsebody;
//       } else {
//         print("Error ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error catch $e");
//     }
//   }
// }
import 'package:http/http.dart' as http;
import 'dart:convert';

class Crud {
  Future<dynamic> getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        // You might want to throw an exception here or return an error object
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("Error catch $e");
      throw Exception("Failed to load data");
    }
  }

  Future<dynamic> postRequest(String url, Map<String, dynamic> data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${response.statusCode}: ${response.body}");
        // You might want to throw an exception here or return an error object
        throw Exception("Failed to make a POST request");
      }
    } catch (e) {
      print("Error catch $e");
      throw Exception("Failed to make a POST request");
    }
  }
}
