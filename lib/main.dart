import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'add_shipment_screen.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YanShip Login',
      home: const ForgotPasswordScreen(),
    );
  }
}
