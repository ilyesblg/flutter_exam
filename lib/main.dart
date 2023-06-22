import 'package:examen_flutter/screens/detail/detail_page.dart';
import 'package:examen_flutter/screens/home/home_page.dart';
import 'package:examen_flutter/screens/login/login_page.dart';
import 'package:examen_flutter/screens/mycoins/mycoins_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(LoginApp());

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        "home": (_) => HomePage(),
        "detail": (_) => DetailPage(),
        "mycoins": (_) => MyCoinsPage(),
      },
    );
  }
}
