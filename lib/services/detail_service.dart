import 'dart:convert';

import 'package:http/http.dart' as http;

Future<bool> buyCoins(String id, String currencyId, String quantity) async {
  // Send the POST request
  print(id);
  Uri url = Uri.parse('http://10.0.2.2:9090/api/currencies/$id');
  print(url);
  Map<String, dynamic> requestBody = {
    'currencyId': currencyId,
    'quantity': quantity,
  };
  print(requestBody);
  try {
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Successful login
      // Navigate to the home page
      // You can handle the response data here
      print('purchase Successful');

      return true;
    } else {
      // Login failed
      // You can handle the error response here
      print('purchase failed: ${response.body}');
      return false;
    }
  } catch (error) {
    // Exception occurred during the request
    print('Error occurred: $error');
    return false;
  }
}
