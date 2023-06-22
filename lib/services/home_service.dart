import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/coin.dart';

Future<List<Coin>?> fetchCoins() async {
  // Send the POST request

  Uri url = Uri.parse('http://10.0.2.2:9090/api/currencies');
  try {
    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // Check the response status code
    if (response.statusCode == 200) {
      // Successful login
      // Navigate to the home page
      // You can handle the response data here
      print('Fetch Successful');
      var jsonResponse = json.decode(response.body);

      return parseJsonResponse(jsonResponse);
    } else {
      // Login failed
      // You can handle the error response here
      print('Fetch failed: ${response.body}');
      return null;
    }
  } catch (error) {
    // Exception occurred during the request
    print('Error occurred: $error');
    return null;
  }
}

List<Coin>? parseJsonResponse(List<dynamic> jsonResponse) {
  if (jsonResponse is List) {
    List<Coin> coins = jsonResponse.map((json) => Coin.fromJson(json)).toList();

    // Do something with the list of objects
    for (var coin in coins) {
      print(coin);
    }
    return coins;
  }
  return null;
}
