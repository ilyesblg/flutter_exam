import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/user.dart';

Future<User?> login(User user) async {
  // Send the POST request
  Uri url = Uri.parse('http://10.0.2.2:9090/api/users/login/id');
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'username': user.username,
        'password': user.password,
      }),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Successful login
      // Navigate to the home page
      // You can handle the response data here
      print('Login successful');
      var jsonResponse = json.decode(response.body);

      return User(
          id: jsonResponse["_id"],
          username: jsonResponse["username"],
          password: jsonResponse["password"],
          balance: jsonResponse["balance"].toDouble());
    } else {
      // Login failed
      // You can handle the error response here
      print('Login failed: ${response.body}');
      return null;
    }
  } catch (error) {
    // Exception occurred during the request
    print('Error occurred: $error');
    return null;
  }
}
