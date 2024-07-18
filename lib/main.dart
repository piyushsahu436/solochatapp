
import 'package:flutter/material.dart';
import 'package:solocaht/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(g
    MaterialApp(
      home: LoginPage(
        onTap: () {
          // Add your onTap action here
          print("Register now tapped");
        },
      ),
    ),
  );
}
